module ram (
    output   wire   [7:0]   out,
    input    wire   [7:0]   in,
    input    wire   [3:0]   address,
    input    wire           enable,
    input    wire           clk,
    input    wire           rst
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
assign  out = RAM[address];
endmodule