`default_nettype none

module blinker(
    input wire[19:0] morse_code,
    input wire i_clk,
    input wire i_rst,
    input wire i_read,
    input wire i_s3,
    input wire i_s7,
    output wire LED_B,
    output reg ready
    //output wire test_clk
);

    wire blinker_clk;
    reg[19:0] blink_data;
    reg[2:0] space_count = 0;

    assign LED_B = blink_data[19];
    //assign test_clk = blinker_clk;

    clock #(
        .MAX_COUNT(2999999),
        .COUNTER_WIDTH(22)
    ) blinker_clk_gen(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_clk(blinker_clk)
    );

    always @ (posedge blinker_clk, posedge i_rst) begin
        if (i_rst) begin
            blink_data <= 0;
            ready <= 1;
        end else if (~ready) begin
            ready <= 0;
            blink_data <= blink_data << 1;
            space_count <= space_count + 1;

            if (i_s3 && space_count < 2) begin
                ready <= 0;
            end else if (i_s7 && space_count < 6) begin
                ready <= 0;
            end else if (~(blink_data[18] || blink_data[17])) begin
                ready <= 1;
            end
        end else if (i_read) begin
            blink_data <= morse_code;
            ready <= 0;
        end
    end
endmodule
