`default_nettype none

module receiver(
    i_clk,
    i_rx,
    i_rst,
    o_data,
    ready
);
    input wire i_clk;
    input wire i_rx;
    input wire i_rst;
    output reg ready;
    output reg[7:0] o_data;

    reg continue_rx;
    reg prev;
    reg rx_steady_val;
    reg [1:0] steady;
    reg[7:0] s_data;
    reg[3:0] bit_counter;

    wire baud_clk;
    wire internal_clk;

    clock #(.N(78)) internal_clk_gen(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_clk(internal_clk)
    );

    clock baud_gen(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_clk(baud_clk)
    );

    always @ (posedge internal_clk) begin
        if (steady == 2'b11) begin
            rx_steady_val <= prev;
            steady <= 0;
        end else if (prev == i_rx) begin
            steady <= steady + 1;
        end else begin
            steady <= 0;
            prev <= i_rx;
        end
    end

    always @ (posedge baud_clk, posedge i_rst) begin
        if (i_rst) begin
            continue_rx <= 0;
            bit_counter <= 0;
            s_data <= 0;
            o_data <= 0;
            ready <= 0;
        end else if (continue_rx) begin
            if (bit_counter < 8) begin
                s_data <= {rx_steady_val, s_data[7:1]};
                bit_counter <= bit_counter + 1;
                ready <= 0;
            end else begin
                continue_rx <= 0;
                o_data <= s_data;
                ready <= 1;
            end
        end else if (~rx_steady_val) begin
            continue_rx <= 1;
            bit_counter <= 0;
            s_data <= 0;
            ready <= 0;
        end
    end
endmodule
