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
    wire LED_R_inv;

    wire uart_ready;
    wire blinker_ready;
    reg blinker_read;

    wire [7:0] rx_ascii;
    wire [19:0] morse_data;
    wire [19:0] morse_data_buff;

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

    buffer morse_buffer (
        .i_clk(clk),
        .i_rst(~SW[0]),
        .i_w_data(morse_data),
        .i_r_next(blinker_ready),
        .o_r_data(morse_data_buff),
        .buff_warn(LED_R_inv)
    );

    blinker morse_blinker (
        .morse_code(morse_data_buff),
        .i_clk(clk),
        .i_rst(~SW[0]),
        .i_read(blinker_ready),
        .i_s3(0),
        .i_s7(0),
        .LED_B(LED_B_inv),
        .ready(blinker_ready)
    );
endmodule
