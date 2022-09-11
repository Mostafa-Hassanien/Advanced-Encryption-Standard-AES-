module shift_rows (
    output   reg     [7:0]    out1, out2, out3, out4,
    output   wire    [7:0]    out_shift_row,
    input    wire    [1:0]    column_index,
    input    wire    [3:0]    address,
    input    wire    [7:0]    in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,
    input    wire             enable,
    input    wire             clk, 
    input    wire             rst
);

integer i;

localparam COLUMN1 = 2'b00,
           COLUMN2 = 2'b01,
           COLUMN3 = 2'b10,
           COLUMN4 = 2'b11;

reg   [7:0]    RAM    [0:15];

always @(posedge clk or negedge rst)
    if (!rst)
        begin
                for (i = 0; i < 16; i = i + 1)
                    RAM[i] <= 8'b0;
            end
        else if(enable)
            begin
                RAM[0]  <= in0;
                RAM[4]  <= in4;
                RAM[8]  <= in8;
                RAM[12] <= in12;
                RAM[1]  <= in5;
                RAM[5]  <= in9;
                RAM[9]  <= in13;
                RAM[13] <= in1;
                RAM[2]  <= in10;
                RAM[6]  <= in14;
                RAM[10] <= in2;
                RAM[14] <= in6;
                RAM[3]  <= in15;
                RAM[7]  <= in3;
                RAM[11] <= in7;
                RAM[15] <= in11;
            end

assign  out_shift_row = RAM[address];

always @(*)
    begin
        case (column_index)
            COLUMN1  : begin
                        out1 = RAM[0];
                        out2 = RAM[1];
                        out3 = RAM[2];
                        out4 = RAM[3];
                    end
            COLUMN2  : begin
                        out1 = RAM[4];
                        out2 = RAM[5];
                        out3 = RAM[6];
                        out4 = RAM[7];
                    end
            COLUMN3  : begin
                        out1 = RAM[8];
                        out2 = RAM[9];
                        out3 = RAM[10];
                        out4 = RAM[11];
                    end
            COLUMN4  : begin
                        out1 = RAM[12];
                        out2 = RAM[13];
                        out3 = RAM[14];
                        out4 = RAM[15];
                    end
            default: begin
                        out1 = RAM[0];
                        out2 = RAM[4];
                        out3 = RAM[8];
                        out4 = RAM[12];
                     end
        endcase
    end
endmodule