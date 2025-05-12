`ifndef __TEST_SV
`define __TEST_SV

module TopTest;

    // testbench signals
    logic clk, reset;
    logic [1:0] result;

    /* instantiate */
    Top top (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    // clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        // initialize signals
        clk = 1;
        reset = 1;
        #10 reset = 0; // release reset

        // wait for result
        wait(result == 2'b10 || result == 2'b01);

        if (result == 2'b10) begin
            $display("Test Passed.");
        end else if (result == 2'b01) begin
            $display("Test Failed.");
        end

        // end simulation
        $finish;
    end

endmodule

`endif
