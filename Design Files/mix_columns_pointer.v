module mix_columns_pointer (
    output   reg    [1:0]    index_num,
    output   wire            last_row,
    input    wire            enable,
    input    wire            column_pointer_clear,
    input    wire            clk,
    input    wire            rst
);

assign last_row = (index_num == 2'd3);

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                index_num <= 2'b0;
            end
        else if (column_pointer_clear)
            begin  
                index_num <= 2'b00;
            end
        else if(enable & !last_row)
            begin
                index_num <= index_num + 2'b1;
            end
        else if (last_row & enable)
            begin
                index_num <= 2'b0;
            end
    end

endmodule