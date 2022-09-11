module rom #(
    parameter TEXT_FILE = "topcipher_data_test_inputs.txt"
)
(
    output   reg    [7:0]   out,
    input    wire   [3:0]   address,
    input    wire   [8:0]   address_depth,
    input    wire           clk
);

reg   [127:0]    ROM    [0:511];

initial 
    begin
        $readmemh(TEXT_FILE, ROM);
    end
always @(*)
    begin   
        case (address)
            4'b0000 : out = ROM[address_depth][127:120];
            4'b0001 : out = ROM[address_depth][119:112];
            4'b0010 : out = ROM[address_depth][111:104];
            4'b0011 : out = ROM[address_depth][103:96];
            4'b0100 : out = ROM[address_depth][95:88];
            4'b0101 : out = ROM[address_depth][87:80];
            4'b0110 : out = ROM[address_depth][79:72];
            4'b0111 : out = ROM[address_depth][71:64];
            4'b1000 : out = ROM[address_depth][63:56];
            4'b1001 : out = ROM[address_depth][55:48];
            4'b1010 : out = ROM[address_depth][47:40];
            4'b1011 : out = ROM[address_depth][39:32];
            4'b1100 : out = ROM[address_depth][31:24];
            4'b1101 : out = ROM[address_depth][23:16];
            4'b1110 : out = ROM[address_depth][15:8];
            4'b1111 : out = ROM[address_depth][7:0];
        endcase
    end
endmodule