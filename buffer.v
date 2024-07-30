`default_nettype none

module buffer(
    input wire i_clk,
    input wire i_rst,
    input wire [19:0] i_w_data,
    input wire i_r_next,
    output wire [19:0] o_r_data,
    output reg buff_warn
);
    reg [3:0] r_addr;
    reg [3:0] w_addr;
    reg [19:0] memory [10];

    integer i;

    always @ (posedge i_clk, posedge i_rst) begin
        if (i_rst) begin
            w_addr <= 0;
            for (i=0; i<10; i=i+1) memory[i] <= 0;
        end else if (i_w_data != memory[w_addr]) begin
            if (w_addr == 9) begin
                if (r_addr == 0) begin
                    buff_warn <= 0;
                end else begin
                    memory[0] <= i_w_data;
                    w_addr <= 0;
                end
            end else begin
                if (r_addr == w_addr + 1) begin
                    buff_warn <= 0;
                end else begin
                    memory[0] <= i_w_data;
                    w_addr <= w_addr + 1;
                end
            end
        end
    end

    assign o_r_data = memory[r_addr];

    always @(posedge i_r_next, posedge i_rst) begin
        if (i_rst) begin
            r_addr <= 0;
        end else if (r_addr != w_addr) begin
            if (r_addr == 9) begin
                r_addr <= 0;
            end else begin
                r_addr <= r_addr + 1;
            end
        end
    end

endmodule
