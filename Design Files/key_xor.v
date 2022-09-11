module key_xor (
    output  wire   [7:0]   out_key_xor1, out_key_xor2, out_key_xor3, out_key_xor4,
    input   wire   [7:0]   in_key_xor1, in_key_xor2, in_key_xor3, in_key_xor4,
    input   wire   [7:0]   in_key_xor5, in_key_xor6, in_key_xor7, in_key_xor8,
    input   wire   [3:0]   round_number,
    input   wire   [1:0]   index_key_epansion
);

reg  [7:0]    rcon;
always @(*)
    begin
        case (round_number)
            4'b0000 :  rcon = 8'h01;
            4'b0001 :  rcon = 8'h02;
            4'b0010 :  rcon = 8'h04;
            4'b0011 :  rcon = 8'h08;
            4'b0100 :  rcon = 8'h10;
            4'b0101 :  rcon = 8'h20;
            4'b0110 :  rcon = 8'h40;
            4'b0111 :  rcon = 8'h80;
            4'b1000 :  rcon = 8'h1b;
            4'b1001 :  rcon = 8'h36;
            default :  rcon = 8'h01;
        endcase
    end

assign out_key_xor1 = (index_key_epansion == 2'b00) ? in_key_xor1 ^ in_key_xor5 ^ rcon : in_key_xor1 ^ in_key_xor5;
assign out_key_xor2 = in_key_xor2 ^ in_key_xor6;
assign out_key_xor3 = in_key_xor3 ^ in_key_xor7;
assign out_key_xor4 = in_key_xor4 ^ in_key_xor8;

endmodule