module print_ciphertext (
    input   wire    [127:0]   ciphertext_result,
    input   wire              enable  
);

integer   monitor_file_id;
localparam MONITOR_FILE = "ciphertext result.txt";

initial 
    begin
        // Open File
        monitor_file_id = $fopen(MONITOR_FILE);

        if (!monitor_file_id)
            begin
                $display ("Error! %s cannot be opened.", MONITOR_FILE);
                $finish;
            end
    end

always @(*)
    begin
        if (enable)
            $fdisplay (monitor_file_id, "%h", ciphertext_result);
    end

endmodule