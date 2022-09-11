module add_round_key (
    output  wire   [7:0]   out,
    input   wire   [7:0]   in1, in2
);

assign out = in1 ^ in2;

endmodule