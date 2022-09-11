// Key Expansion Start from W1 (XOR) RCON Matrix
module aes_top_module (
    output   wire  [127:0]  print_ciphertext_result,
    input    wire           clk,
    input    wire           rst 
);

wire  [7:0]  out_key_matrix, out_state_rom, in_state_matrix, in_key_matrix, out_Round_Key, out_state_matrix;
wire  [7:0]  in_sub_bytes, out_add_round_key, out_sub_bytes, in_mixed_column;
wire  [7:0]  in_mix_column1, in_mix_column2, in_mix_column3, in_mix_column4;
wire  [3:0]  pc;
wire  [1:0]  index_column, index_row, index, index_key_epansion;
wire  [7:0]  out1_column, out2_column, out3_column, out4_column, out5_column, out6_column, out7_column, out8_column;
wire  [7:0]  out_rotated_column1, out_rotated_column2, out_rotated_column3, out_rotated_column4;
reg   [7:0]  out_rotated_column;
wire  [7:0]  in_add_round_key, out_shift_row;
wire         print_ciphertext, en_cipher_text, print_file;
wire         en_state_matrix, en_load_inputs, en_out, en_counter, overflow_flag, sb_valid_in, en_shift_rows;
wire         last_row, en_mix_column_pointer_row, last_column, en_mix_column_pointer_column, enable_mix_column;
wire         en_key_reg_file_column, en_sub_bytes_key_pointer, last_index, round_overflow_flag;
wire         incremet_round, last_index_key_epansion, en_key_epansion, clear_pc, column_pointer_clear;
wire  [7:0]  out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15;
wire  [31:0]  out_first_term_key_expansion;
wire  [7:0]   out_key_xor1, out_key_xor2, out_key_xor3, out_key_xor4;
wire  [8:0]   pc_ciphertext;
wire  [3:0]   round_number;


ciphertext_pointer U0_Ciphertext_Pointer (
    .pc(pc_ciphertext),
    .enable(en_cipher_text),
    .clk(clk),
    .rst(rst)
);

rom #(.TEXT_FILE("topcipher_data_test_inputs.txt")) U0_ROM_Message (
    .out(out_state_rom),
    .address_depth(pc_ciphertext),
    .address(pc),
    .clk(clk)
);

rom #(.TEXT_FILE("topcipher_key_test_inputs.txt")) U1_ROM_Key (
    .out(in_key_matrix),
    .address_depth(pc_ciphertext),
    .address(pc),
    .clk(clk)
);

ram U2_State_Matrix (
    .out(out_state_matrix),
    .in(in_state_matrix),
    .address(pc),
    .enable(en_state_matrix),
    .clk(clk),
    .rst(rst)
);

assign en_state_matrix = en_load_inputs | enable_mix_column;
assign in_state_matrix = en_load_inputs ? out_state_rom : in_mixed_column;

ram_key_matrix U3_Key_Matrix (
    .out(out_key_matrix),
    .out1(out1_column),
    .out2(out2_column),
    .out3(out3_column),
    .out4(out4_column),
    .out5(out5_column),
    .out6(out6_column),
    .out7(out7_column),
    .out8(out8_column),
    .in1(out_key_xor1),
    .in2(out_key_xor2),
    .in3(out_key_xor3),
    .in4(out_key_xor4),
    .in(in_key_matrix),
    .column_number(index_key_epansion),
    .enable_key(en_key_reg_file_column),
    .en_key_epansion(en_key_epansion),
    .address(pc),
    .enable(en_load_inputs),
    .clk(clk),
    .rst(rst)
);

mux2X1 U3_Mux_Key_Expansion (
    .out(out_first_term_key_expansion),
    .in1({out_rotated_column1, out_rotated_column2, out_rotated_column3, out_rotated_column4}),
    .in2({out5_column, out6_column, out7_column, out8_column}),
    .sel(index_key_epansion)
);

key_xor U3_Key_XOR_RCON (
    .out_key_xor1(out_key_xor1), 
    .out_key_xor2(out_key_xor2), 
    .out_key_xor3(out_key_xor3), 
    .out_key_xor4(out_key_xor4),
    .in_key_xor1(out1_column), 
    .in_key_xor2(out2_column), 
    .in_key_xor3(out3_column), 
    .in_key_xor4(out4_column),
    .in_key_xor5(out_first_term_key_expansion[31:24]), 
    .in_key_xor6(out_first_term_key_expansion[23:16]), 
    .in_key_xor7(out_first_term_key_expansion[15:8]), 
    .in_key_xor8(out_first_term_key_expansion[7:0]),
    .round_number(round_number),
    .index_key_epansion(index_key_epansion)
);


mix_columns_pointer U3_Key_Expansion_Pointer (
    .index_num(index_key_epansion),
    .last_row(last_index_key_epansion),
    .column_pointer_clear(column_pointer_clear),
    .enable(en_key_epansion),
    .clk(clk),
    .rst(rst)
);


column_reg_file U3_Rotated_Column4_Key (
    .out1(out_rotated_column1),
    .out2(out_rotated_column2),
    .out3(out_rotated_column3),
    .out4(out_rotated_column4),
    .in(out_sub_bytes),
    .in1(out1_column),
    .in2(out2_column),
    .in3(out3_column),
    .in4(out4_column),
    .index(index),
    .enable(en_key_reg_file_column),
    .enable2(en_sub_bytes_key_pointer),
    .clk(clk),
    .rst(rst)   
);

always @(*)
    begin
        case (index)
            2'b00 : out_rotated_column = out_rotated_column1;
            2'b01 : out_rotated_column = out_rotated_column2;
            2'b10 : out_rotated_column = out_rotated_column3;
            2'b11 : out_rotated_column = out_rotated_column4;
        endcase
    end

mix_columns_pointer U3_Sub_Bytes_Key (
    .index_num(index),
    .last_row(last_index),
    .enable(en_sub_bytes_key_pointer),
    .column_pointer_clear(column_pointer_clear),
    .clk(clk),
    .rst(rst)
);

pointer_counter U4_Pointer_Counter (
    .pc(pc),
    .clear_pc(clear_pc),
    .overflow_flag(overflow_flag),
    .enable(en_counter),
    .clk(clk),
    .rst(rst)
);

fsm_controller U5_FSM_Controller (
    .en_counter(en_counter),
    .print_file(print_file),
    .en_cipher_text(en_cipher_text),
    .print_ciphertext(print_ciphertext),
    .clear_pc(clear_pc),
    .clear_round_number(clear_round_number),
    .last_index_key_epansion(last_index_key_epansion),
    .en_key_epansion(en_key_epansion),
    .en_sub_bytes_key_pointer(en_sub_bytes_key_pointer),
    .incremet_round(incremet_round),
    .round_overflow_flag(round_overflow_flag),
    .en_key_reg_file_column(en_key_reg_file_column),
    .en_load_inputs(en_load_inputs),
    .en_out(en_out),
    .overflow_flag(overflow_flag),
    .sb_valid_in(sb_valid_in),
    .en_shift_rows(en_shift_rows),
    .last_row(last_row),
    .en_mix_column_pointer_row(en_mix_column_pointer_row),
    .last_column(last_column),
    .last_index(last_index),
    .en_mix_column_pointer_column(en_mix_column_pointer_column),
    .enable_mix_column(enable_mix_column),
    .clk(clk),
    .rst(rst)
);

add_round_key U6_Add_Round_Key (
    .out(out_Round_Key),
    .in1(in_add_round_key),
    .in2(out_key_matrix)
);

assign in_add_round_key = print_ciphertext ? out_shift_row : out_state_matrix;

ram_round_key U7_After_Add_Round_Key_Stage (
    .out(out_add_round_key),
    .print_ciphertext_result(print_ciphertext_result),
    .in(out_Round_Key),
    .address(pc),
    .enable(en_out),
    .clk(clk),
    .rst(rst)
);

print_ciphertext U14_print_ciphertext (
    .ciphertext_result(print_ciphertext_result),
    .enable(print_file)
);
 
assign in_sub_bytes = en_out ? out_add_round_key : out_rotated_column;

SBox U8_Substitute_Box (
    .dout(out_sub_bytes),
    .addr(in_sub_bytes),
    .valid_in(sb_valid_in)
);

ram_sub_box U9_After_Substitute_Box_Stage (
    .out0(out0), .out1(out1), .out2(out2), .out3(out3), .out4(out4), .out5(out5), 
    .out6(out6), .out7(out7), .out8(out8), .out9(out9), .out10(out10), .out11(out11), 
    .out12(out12), .out13(out13), .out14(out14), .out15(out15),
    .in(out_sub_bytes),
    .address(pc),
    .enable(en_out),
    .clk(clk),
    .rst(rst)
);

shift_rows U10_After_Shift_Rows_Stage (
    .out_shift_row(out_shift_row),
    .address(pc),
    .out1(in_mix_column1),
    .out2(in_mix_column2),
    .out3(in_mix_column3),
    .out4(in_mix_column4),
    .column_index(index_column),
    .in0(out0), .in1(out1), .in2(out2), .in3(out3), .in4(out4), .in5(out5), 
    .in6(out6), .in7(out7), .in8(out8), .in9(out9), .in10(out10), .in11(out11), 
    .in12(out12), .in13(out13), .in14(out14), .in15(out15),
    .enable(en_shift_rows),
    .clk(clk),
    .rst(rst)
);

mix_columns_pointer U11_Mix_Columns_Pointer_ROWS (
    .index_num(index_row),
    .last_row(last_row),
    .enable(en_mix_column_pointer_row),
    .column_pointer_clear(clear_pc),
    .clk(clk),
    .rst(rst)
);

mix_columns_pointer U12_Mix_Columns_Pointer_Columns (
    .index_num(index_column),
    .last_row(last_column),
    .column_pointer_clear(clear_pc),
    .enable(en_mix_column_pointer_column),
    .clk(clk),
    .rst(rst)
);

mix_columns U13_Mix_Columns (
    .out(in_mixed_column),
    .row_index(index_row),
    .in1(in_mix_column1),
    .in2(in_mix_column2),
    .in3(in_mix_column3),
    .in4(in_mix_column4)
);



round_counter U3_Round_Counter (
    .pc(round_number),
    .clear(clear_round_number),
    .overflow_flag(round_overflow_flag),
    .print_ciphertext(print_ciphertext),
    .enable(incremet_round),
    .clk(clk),
    .rst(rst)
);

endmodule