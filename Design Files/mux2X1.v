module mux2X1 (
    output   reg    [31:0]   out,
    input    wire   [31:0]   in1, in2,
    input    wire   [1:0]    sel
);

always @(*)
    begin
        case (sel)
            2'b00 : out = in1;
            default : out = in2;
        endcase 
    end

endmodule