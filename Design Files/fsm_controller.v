module fsm_controller (
    output    reg     en_counter, en_load_inputs, en_out, sb_valid_in, en_shift_rows,
    output    reg     en_key_reg_file_column, en_sub_bytes_key_pointer, incremet_round,
    output    reg     en_mix_column_pointer_row, en_mix_column_pointer_column, enable_mix_column,
    output    reg     en_key_epansion, clear_pc, clear_round_number, en_cipher_text, print_file,
    input     wire    overflow_flag, last_row, last_column, last_index, round_overflow_flag,
    input     wire    last_index_key_epansion, print_ciphertext,
    input     wire    clk,
    input     wire    rst
);

parameter   IDLE         = 4'b000,
            LOAD         = 4'b001,
            ADDROUNDKEY  = 4'b010,
            SUBBYTES     = 4'b011,
            SHIFTROWS    = 4'b100,
            MIXCOLUMNS   = 4'b101,
            CALCMIXCOLUM = 4'b110,
            NEXTKEY      = 4'b111,
            ADDNEXTKEY   = 4'b1000,
            LASTROUND    = 4'b1001;

reg  [3:0]   current_state, next_state;

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                current_state <= IDLE;
            end
        else 
            begin
                current_state <= next_state;
            end
    end

always @(*)
    begin
        case (current_state)
            IDLE        : begin
                            next_state = LOAD;
                          end
            LOAD        : begin
                            if (overflow_flag)
                                next_state = ADDROUNDKEY;
                            else 
                                next_state = LOAD;
                          end
            ADDROUNDKEY : begin
                            case ({print_ciphertext, overflow_flag})
                                2'b00 : next_state = ADDROUNDKEY;
                                2'b01 : next_state = SUBBYTES;
                                2'b11 : next_state = LASTROUND;
                                default : next_state = ADDROUNDKEY;
                            endcase 
                          end
            SUBBYTES    : begin
                            case (overflow_flag)
                             2'b0: next_state = SUBBYTES;
                             2'b1: next_state = SHIFTROWS;
                            endcase
                          end
            SHIFTROWS   : begin
                            next_state = CALCMIXCOLUM;
                          end
            MIXCOLUMNS  : begin
                                next_state = CALCMIXCOLUM;
                          end
            CALCMIXCOLUM: begin
                            case ({last_column, last_row})
                                2'b01: next_state = MIXCOLUMNS;
                                2'b11: next_state = NEXTKEY;
                                default : next_state = CALCMIXCOLUM;
                            endcase
                          end
            NEXTKEY     : begin
                            if (last_index_key_epansion)
                                next_state = ADDNEXTKEY;
                            else 
                                next_state = NEXTKEY;
                          end
            ADDNEXTKEY  : begin
                            next_state = ADDROUNDKEY;
                          end   
            LASTROUND   :  next_state = IDLE;
            default     : begin 
                            next_state = IDLE;
                          end
        endcase
    end
always @(*)
    begin
        case (current_state)
            IDLE        : begin
                            en_counter     = 1'b0;
                            print_file     = 1'b0;
                            en_cipher_text = 1'b0;
                            clear_pc       = 1'b1;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b1;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            LOAD        : begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            en_cipher_text = 1'b0;
                            clear_pc       = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b1;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            ADDROUNDKEY : begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b1;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b1;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            SUBBYTES    : begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b1;
                            sb_valid_in    = 1'b1;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            SHIFTROWS   : begin
                            en_counter     = 1'b0;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b1;
                            en_shift_rows  = 1'b1;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b1;
                            en_key_epansion              = 1'b0;
                          end
            MIXCOLUMNS  : begin  
                            en_counter     = 1'b0;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            incremet_round = 1'b0;
                            en_cipher_text = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b1;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b1;
                            en_key_epansion              = 1'b0;
                          end
            CALCMIXCOLUM: begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b1;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b1;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = round_overflow_flag ? 1'b0 : 1'b1;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            NEXTKEY     : begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;  
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b1;
                          end
            ADDNEXTKEY  : begin
                            en_counter     = 1'b1;
                            print_file     = 1'b0;
                            clear_pc       = 1'b1;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b1;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;  
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            LASTROUND   : begin  
                            en_counter     = 1'b0;
                            clear_pc       = 1'b0;
                            print_file     = 1'b1;
                            en_cipher_text = 1'b1;
                            clear_round_number = 1'b1;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b1;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
            default     : begin  
                            en_counter     = 1'b0;
                            print_file     = 1'b0;
                            clear_pc       = 1'b0;
                            en_cipher_text = 1'b0;
                            incremet_round = 1'b0;
                            en_load_inputs = 1'b0;
                            en_out         = 1'b0;
                            sb_valid_in    = 1'b0;
                            en_shift_rows  = 1'b0;
                            clear_round_number           = 1'b0;
                            en_mix_column_pointer_row    = 1'b0;
                            en_mix_column_pointer_column = 1'b0;
                            enable_mix_column            = 1'b0;
                            en_key_reg_file_column       = 1'b0;
                            en_sub_bytes_key_pointer     = 1'b0;
                            en_key_epansion              = 1'b0;
                          end
        endcase
    end
endmodule