module mix_columns (
    output   reg    [7:0]   out,
    input    wire   [1:0]   row_index,
    input    wire   [7:0]   in1, in2, in3, in4
);

localparam ROW1 = 2'b00,
           ROW2 = 2'b01,
           ROW3 = 2'b10,
           ROW4 = 2'b11;

always @(*)
    begin
        case (row_index)
            ROW1  : begin
                        case({in1[7], in2[7]})
                            2'b00 : out = (in1 << 1) ^ ((in2 << 1) ^ in2) ^ in3 ^ in4;
                            2'b11 : out = (in1 << 1) ^ ((in2 << 1) ^ in2) ^ in3 ^ in4 ^ 8'b0001_1011 ^ 8'b0001_1011; 
                            default : out = (in1 << 1) ^ ((in2 << 1) ^ in2) ^ in3 ^ in4 ^ 8'b0001_1011;
                        endcase
                    end
            ROW2  : begin
                        case({in2[7], in3[7]})
                            2'b00 : out =  in1 ^ (in2 << 1) ^ ((in3 << 1) ^ in3) ^ in4;
                            2'b11 : out =  in1 ^ (in2 << 1) ^ ((in3 << 1) ^ in3) ^ in4 ^ 8'b0001_1011 ^ 8'b0001_1011; 
                            default : out =  in1 ^ (in2 << 1) ^ ((in3 << 1) ^ in3) ^ in4 ^ 8'b0001_1011;
                        endcase
                    end
            ROW3  : begin
                        case({in3[7], in4[7]})
                            2'b00 : out =  in1 ^ in2 ^ (in3 << 1) ^ ((in4 << 1) ^ in4);
                            2'b11 : out =  in1 ^ in2 ^ (in3 << 1) ^ ((in4 << 1) ^ in4) ^ 8'b0001_1011 ^ 8'b0001_1011; 
                            default : out =   in1 ^ in2 ^ (in3 << 1) ^ ((in4 << 1) ^ in4) ^ 8'b0001_1011;
                        endcase
                    end
            ROW4  : begin
                        case({in4[7], in1[7]})
                            2'b00 : out = ((in1 << 1) ^ in1) ^ in2 ^ in3 ^ (in4 << 1);
                            2'b11 : out =  ((in1 << 1) ^ in1) ^ in2 ^ in3 ^ (in4 << 1) ^ 8'b0001_1011 ^ 8'b0001_1011; 
                            default : out =  ((in1 << 1) ^ in1) ^ in2 ^ in3 ^ (in4 << 1) ^ 8'b0001_1011;
                        endcase
                    end
            default: begin
                        out = (in1 << 1) ^ ((in2 << 1) ^ in2) ^ in3 ^ in4;
                     end
        endcase
    end
endmodule