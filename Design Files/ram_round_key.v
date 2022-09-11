module ram_round_key (
    output   wire   [7:0]   out,
    output   wire   [127:0] print_ciphertext_result,
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
assign print_ciphertext_result = {RAM[0],RAM[1],RAM[2],RAM[3],RAM[4],RAM[5],RAM[6],RAM[7],RAM[8],RAM[9],RAM[10],RAM[11],RAM[12],RAM[13],RAM[14],RAM[15]};
endmodule