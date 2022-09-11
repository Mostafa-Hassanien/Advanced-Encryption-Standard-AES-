module ciphertext_pointer (
    output   reg    [8:0]    pc,
    input    wire            enable,
    input    wire            clk,
    input    wire            rst
);

assign overflow_flag = (pc == 9'h1ff);

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                pc <= 9'b0;
            end
        else if(enable & !overflow_flag)
            begin 
                pc <= pc + 9'b1;
            end
        else if (overflow_flag)
            begin
                pc <= 9'b0;
            end
    end


endmodule