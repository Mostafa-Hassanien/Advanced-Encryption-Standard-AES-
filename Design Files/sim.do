# vsim work.aes_top_module 
# Start time: 03:12:52 on Mar 25,2022
# Loading work.aes_top_module
# Loading work.rom
# Loading work.ram
# Loading work.pointer_counter
# Loading work.fsm_controller
# Loading work.add_round_key
add wave -position insertpoint  \
sim:/aes_top_module/in_sub_bytes \
sim:/aes_top_module/clk \
sim:/aes_top_module/rst
add wave -position insertpoint  \
sim:/aes_top_module/U7_After_Add_Round_Key_Stage/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U2_State_Matrix/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U3_Key_Matrix/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U5_FSM_Controller/current_state \
sim:/aes_top_module/U5_FSM_Controller/next_state
add wave -position insertpoint  \
sim:/aes_top_module/U4_Pointer_Counter/pc \
sim:/aes_top_module/U4_Pointer_Counter/enable
add wave -position insertpoint  \
sim:/aes_top_module/U7_After_Add_Round_Key_Stage/enable
add wave -position insertpoint  \
sim:/aes_top_module/U7_After_Add_Round_Key_Stage/in
add wave -position insertpoint  \
sim:/aes_top_module/U6_Add_Round_Key/out \
sim:/aes_top_module/U6_Add_Round_Key/in1 \
sim:/aes_top_module/U6_Add_Round_Key/in2
add wave -position insertpoint  \
sim:/aes_top_module/U8_Substitute_Box/valid_in \
sim:/aes_top_module/U8_Substitute_Box/addr \
sim:/aes_top_module/U8_Substitute_Box/dout
add wave -position insertpoint  \
sim:/aes_top_module/U9_After_Substitute_Box_Stage/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U10_After_Shift_Rows_Stage/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U13_Mix_Columns/out \
sim:/aes_top_module/U13_Mix_Columns/in1 \
sim:/aes_top_module/U13_Mix_Columns/in2 \
sim:/aes_top_module/U13_Mix_Columns/in3 \
sim:/aes_top_module/U13_Mix_Columns/in4
add wave -position insertpoint  \
sim:/aes_top_module/U5_FSM_Controller/en_mix_column_pointer_row \
sim:/aes_top_module/U5_FSM_Controller/en_mix_column_pointer_column \
sim:/aes_top_module/U5_FSM_Controller/enable_mix_column
add wave -position insertpoint  \
sim:/aes_top_module/U5_FSM_Controller/last_row \
sim:/aes_top_module/U5_FSM_Controller/last_column
add wave -position insertpoint  \
sim:/aes_top_module/U5_FSM_Controller/current_state \
sim:/aes_top_module/U5_FSM_Controller/next_state
add wave -position insertpoint  \
sim:/aes_top_module/U12_Mix_Columns_Pointer_Columns/index_num
add wave -position insertpoint  \
sim:/aes_top_module/U11_Mix_Columns_Pointer_ROWS/index_num
add wave -position insertpoint  \
sim:/aes_top_module/U13_Mix_Columns/row_index
add wave -position insertpoint  \
sim:/aes_top_module/U3_Rotated_Column4_Key/RAM
add wave -position insertpoint  \
sim:/aes_top_module/U3_Key_Expansion_Pointer/index_num \
sim:/aes_top_module/U3_Key_Expansion_Pointer/last_row \
sim:/aes_top_module/U3_Key_Expansion_Pointer/enable \
sim:/aes_top_module/U3_Key_Expansion_Pointer/clk \
sim:/aes_top_module/U3_Key_Expansion_Pointer/rst
add wave -position insertpoint  \
sim:/aes_top_module/round_number
force -freeze sim:/aes_top_module/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/aes_top_module/rst 1 0
force -freeze sim:/aes_top_module/rst 0 10
force -freeze sim:/aes_top_module/rst 1 60
