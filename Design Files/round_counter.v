module round_counter (
    output   reg    [3:0]    pc,
    output   wire            overflow_flag, print_ciphertext,
    input    wire            enable,
    input    wire            clear,
    input    wire            clk,
    input    wire            rst
);

assign overflow_flag    = (pc == 4'd9);
assign print_ciphertext = (pc == 4'd10);

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                pc <= 4'b0;
            end
        else if(clear)
            begin
                pc <= 4'b0;
            end
        else if(enable)
            begin
                
                pc <= pc + 4'b1;
            end
    end

endmodule