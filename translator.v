`default_nettype none

module translator (
    input wire[7:0] in_ascii,
    output reg[19:0] out
);

    parameter bit[3:0] DASH = 4'b1110;
    parameter bit[1:0] DOT = 2'b10;

    always @ (in_ascii) begin
        casez (in_ascii)
            8'b00110000: out = { 5{DASH}};                          // ASCII 0
            8'b00110001: out = { {1{DOT}}, {4{DASH}}, {2'b0} };     // ASCII 1
            8'b00110010: out = { {2{DOT}}, {3{DASH}}, {4'b0} };     // ASCII 2
            8'b00110011: out = { {3{DOT}}, {2{DASH}}, {6'b0} };     // ASCII 3
            8'b00110100: out = { {4{DOT}}, {1{DASH}}, {8'b0} };     // ASCII 4
            8'b00110101: out = { {5{DOT}}, {0{DASH}}, {10'b0} };    // ASCII 5
            8'b00110110: out = { {1{DASH}}, {4{DOT}}, {8'b0} };     // ASCII 6
            8'b00110111: out = { {2{DASH}}, {3{DOT}}, {6'b0} };     // ASCII 7
            8'b00111000: out = { {3{DASH}}, {2{DOT}}, {4'b0} };     // ASCII 8
            8'b00111001: out = { {4{DASH}}, {1{DOT}}, {2'b0} };     // ASCII 9

            // ASCII A
            8'b01?00001: out = { DOT, DASH, 14'b0 };
            //ASCII B
            8'b01?00010: out = { DASH, {3{DOT}}, 10'b0 };
            //ASCII C
            8'b01?00011: out = { {2{DASH, DOT}}, 8'b0 };
            //ASCII D
            8'b01?00100: out = { DASH, {2{DOT}}, 12'b0};
            //ASCII E
            8'b01?00101: out = { DASH, 16'b0 };
            //ASCII F
            8'b01?00110: out = { {2{DOT}}, DASH, DOT, 10'b0 };
            //ASCII G
            8'b01?00111: out = { {2{DASH}}, DOT, 10'b0 };
            //ASCII H
            8'b01?01000: out = { {4{DOT}}, 12'b0 };
            //ASCII I
            8'b01?01001: out = { {2{DOT}}, 16'b0 };
            //ASCII J
            8'b01?01010: out = { DOT, {3{DASH}}, 6'b0 };
            //ASCII K
            8'b01?01011: out = { DASH, DOT, DASH, 10'b0 };
            //ASCII L
            8'b01?01100: out = { DOT, DASH, {2{DOT}}, 10'b0};
            //ASCII M
            8'b01?01101: out = { {2{DASH}}, 12'b0 };
            //ASCII N
            8'b01?01110: out = { DASH, DOT, 14'b0 };
            //ASCII O
            8'b01?01111: out = { {3{DASH}}, 8'b0 };
            //ASCII P
            8'b01?10000: out = { DOT, DASH, DASH, DOT, 8'b0 };
            //ASCII Q
            8'b01?10001: out = { {2{DASH}}, DOT, DASH, 6'b0};
            //ASCII R
            8'b01?10010: out = { DOT, DASH, DOT, 12'b0 };
            //ASCII S
            8'b01?10011: out = { DOT, DOT, DOT, 14'b0 };
            //ASCII T
            8'b01?10100: out = { DASH, 16'b0 };
            //ASCII U
            8'b01?10101: out = { DOT, DOT, DASH, 12'b0 };
            //ASCII V
            8'b01?10110: out = { {3{DOT}}, DASH, 10'b0 };
            //ASCII W
            8'b01?10111: out = { DOT, DASH, DASH, 10'b0 };
            //ASCII X
            8'b01?11000: out = { DASH, DOT, DOT, DASH, 8'b0 };
            //ASCII Y
            8'b01?11001: out = { DASH, DOT, {2{DASH}}, 6'b0 };
            //ASCII Z
            8'b01?11010: out = { {2{DASH}}, {2{DOT}}, 8'b0 };

            default : out = 0;
        endcase
    end
endmodule
