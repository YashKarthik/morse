`default_nettype none

module clock #(
    parameter integer COUNTER_WIDTH = 13,
    parameter reg[COUNTER_WIDTH-1:0] MAX_COUNT = 624
) (
    input wire i_clk,
    input wire i_rst,
    output reg o_clk
);

    reg [COUNTER_WIDTH-1:0] counter;

    always @ (posedge i_clk, posedge i_rst) begin
        if (i_rst) begin
            counter <= 0;
            o_clk <= 0;
        end else if (counter == MAX_COUNT) begin
            counter <= 0;
            o_clk <= ~o_clk;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
