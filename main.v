`default_nettype none

module main (
    input wire clk,
    input wire RX,
    input wire[3:0] SW, // SW[0] is global reset
    output wire LED_R,
    output wire LED_G,
    output wire LED_B
);

    wire LED_B_inv;
    reg LED_R_inv;

    wire uart_ready;
    wire blinker_ready;
    reg blinker_read;

    wire [7:0] rx_ascii;
    reg [19:0] morse_data;
    reg [10:0] morse_data_buff;

    assign LED_B = ~LED_B_inv;
    assign LED_R = ~LED_R_inv;
    assign LED_G = ~blinker_ready;

    receiver uart_rx(
        .i_clk(clk),
        .i_rx(RX),
        .i_rst(~SW[0]),
        .o_data(rx_ascii),
        .ready(uart_ready)
    );

    translator morse_trsltr (
        .in_ascii(rx_ascii),
        .out(morse_data)
    );

    blinker morse_blinker (
        .morse_code(morse_data),
        .i_clk(clk),
        .i_rst(~SW[0]),
        .i_read(~SW[1]),
        .i_s3(0),
        .i_s7(0),
        .LED_B(LED_B_inv),
        .ready(blinker_ready)
    );

    always @ (posedge blinker_ready) begin
        morse_data_buff <= morse_data[19:9];
        blinker_read <= 1;
    end

    always @ (posedge clk) begin
        LED_R_inv <= 0;
        if (~uart_ready && ~blinker_ready) begin
            LED_R_inv <= 1;
        end
    end

endmodule
