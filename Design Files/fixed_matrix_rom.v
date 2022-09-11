module fixed_matrix_rom #(
    parameter TEXT_FILE = "Column_Matrix.txt"
)
(
    output   reg    [7:0]   out1, out2, out3, out4,
    input    wire   [1:0]   row_index,
    input    wire           clk
);

reg   [7:0]    ROM    [0:15];

localparam ROW1 = 2'b00,
           ROW2 = 2'b01,
           ROW3 = 2'b10,
           ROW4 = 2'b11;

initial 
    begin
        $readmemh(TEXT_FILE, ROM);
    end
always @(*)
    begin
        case (row_index)
            ROW1  : begin
                        out1 = ROM[0];
                        out2 = ROM[4];
                        out3 = ROM[8];
                        out4 = ROM[12];
                    end
            ROW2  : begin
                        out1 = ROM[1];
                        out2 = ROM[5];
                        out3 = ROM[9];
                        out4 = ROM[13];
                    end
            ROW3  : begin
                        out1 = ROM[2];
                        out2 = ROM[6];
                        out3 = ROM[10];
                        out4 = ROM[14];
                    end
            ROW4  : begin
                        out1 = ROM[3];
                        out2 = ROM[7];
                        out3 = ROM[11];
                        out4 = ROM[15];
                    end
            default: begin
                        out1 = ROM[0];
                        out2 = ROM[4];
                        out3 = ROM[8];
                        out4 = ROM[12];
                     end
        endcase
    end
endmodule