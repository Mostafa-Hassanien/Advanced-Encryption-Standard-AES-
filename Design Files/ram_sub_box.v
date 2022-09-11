module ram_sub_box (
    output   reg    [7:0]     out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,
    input    wire   [7:0]     in,
    input    wire   [3:0]     address,
    input    wire             enable,
    input    wire             clk,
    input    wire             rst
);

integer  i;

reg   [7:0]    RAM    [0:15];

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                for (i = 0; i < 16; i = i + 1)
                    RAM[i] <= 8'b0;
            end
        else if(enable)
            begin
                RAM[address] <= in;
            end
    end

always @(*)
    begin
        out0  = RAM[0];
        out1  = RAM[1];
        out2  = RAM[2];
        out3  = RAM[3];
        out4  = RAM[4];
        out5  = RAM[5];
        out6  = RAM[6];
        out7  = RAM[7];
        out8  = RAM[8];
        out9  = RAM[9];
        out10 = RAM[10];
        out11 = RAM[11];
        out12 = RAM[12];
        out13 = RAM[13];
        out14 = RAM[14];
        out15 = RAM[15];
    end
endmodule