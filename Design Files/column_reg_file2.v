module column_reg_file2 (
    output   reg    [7:0]   out1, out2, out3, out4,
    input    wire   [7:0]   in,
    input    wire   [1:0]   index,
    input    wire           enable,
    input    wire           clk,
    input    wire           rst
);

integer  i;

localparam COLUMN1 = 2'b00,
           COLUMN2 = 2'b01,
           COLUMN3 = 2'b10,
           COLUMN4 = 2'b11;

reg   [7:0]    RAM    [0:3];

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                for (i = 0; i < 4; i = i + 1)
                    RAM[i] <= 8'b0;
            end
        else if(enable)
            begin
                RAM[index] <= in;
            end
    end
    always @(*)
        begin
          out1 = RAM[0];
          out2 = RAM[1];
          out3 = RAM[2];
          out4 = RAM[3];
        end

endmodule