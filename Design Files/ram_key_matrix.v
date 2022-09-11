module ram_key_matrix (
    output   wire   [7:0]   out,
    output   reg    [7:0]   out1, out2, out3, out4, out5, out6, out7, out8,
    input    wire   [7:0]   in, in1, in2, in3, in4,
    input    wire   [3:0]   address,
    input    wire   [1:0]   column_number,
    input    wire           enable, enable_key, en_key_epansion,
    input    wire           clk,
    input    wire           rst
);

integer  i;

localparam COLUMN1 = 2'b00,
           COLUMN2 = 2'b01,
           COLUMN3 = 2'b10,
           COLUMN4 = 2'b11;

wire  [3:0]   shifted_colum_num;
assign shifted_colum_num = column_number << 2;


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
        else if(en_key_epansion)
            begin
                RAM[shifted_colum_num]     <= in1;
                RAM[shifted_colum_num + 1] <= in2;
                RAM[shifted_colum_num + 2] <= in3;
                RAM[shifted_colum_num + 3] <= in4;
            end
    end
assign out  = RAM[address];
always @(*)
    begin
        if (enable_key)
            begin 
                out1 = RAM[12];
                out2 = RAM[13];
                out3 = RAM[14];
                out4 = RAM[15];
            end
        else 
            begin
                case (column_number)
                    2'b00 : begin
                        out1 = RAM[0];
                        out2 = RAM[1];
                        out3 = RAM[2];
                        out4 = RAM[3];
                        out5 = RAM[0];
                        out6 = RAM[1];
                        out7 = RAM[2];
                        out8 = RAM[3];
                    end
                    2'b01 : begin
                        out1 = RAM[4];
                        out2 = RAM[5];
                        out3 = RAM[6];
                        out4 = RAM[7];
                        out5 = RAM[0];
                        out6 = RAM[1];
                        out7 = RAM[2];
                        out8 = RAM[3];
                    end
                    2'b10 : begin
                        out1 = RAM[8];
                        out2 = RAM[9];
                        out3 = RAM[10];
                        out4 = RAM[11];
                        out5 = RAM[4];
                        out6 = RAM[5];
                        out7 = RAM[6];
                        out8 = RAM[7];
                    end
                    2'b11 : begin
                        out1 = RAM[12];
                        out2 = RAM[13];
                        out3 = RAM[14];
                        out4 = RAM[15];
                        out5 = RAM[8];
                        out6 = RAM[9];
                        out7 = RAM[10];
                        out8 = RAM[11];
                    end
                    default : begin
                        out1 = RAM[12];
                        out2 = RAM[13];
                        out3 = RAM[14];
                        out4 = RAM[15];
                        out5 = RAM[0];
                        out6 = RAM[1];
                        out7 = RAM[2];
                        out8 = RAM[3];
                    end
                endcase
            end
    end

endmodule