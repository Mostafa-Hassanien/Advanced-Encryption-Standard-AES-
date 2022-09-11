module pointer_counter (
    output   reg    [3:0]    pc,
    output   wire            overflow_flag,
    input    wire            clear_pc,
    input    wire            enable,
    input    wire            clk,
    input    wire            rst
);

assign overflow_flag = (pc == 4'd15);

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                pc <= 4'b0;
            end
        else if(clear_pc)
            begin 
                pc <= 4'b0;
            end
        else if(enable & !overflow_flag)
            begin 
                pc <= pc + 4'b1;
            end
        else if (overflow_flag)
            begin
                pc <= 4'b0;
            end
    end

endmodule