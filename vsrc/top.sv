`ifndef __TOP_SV
`define __TOP_SV

module Top
    (
        input logic clk, reset,
        output logic[1:0] result
    );
    
    logic [31:0] srca, srcb, alu_result;
    logic [4:0] alufunc;

    logic all_passed;
    
   
    alu alu (
        .srca(srca),
        .srcb(srcb),
        .alufunc(alufunc),
        .result(alu_result)
    );

   
   task run_test(input logic [31:0] a, input logic [31:0] b, input logic [4:0] func, 
                  input logic [31:0] expected);
        begin
            srca = a;
            srcb = b;
            alufunc = func;
            #10;  

           

            if (alu_result !== expected) begin
                $display("ERROR: %0d %0d %0d = %0d (Expected: %0d)", a, func, b, alu_result, expected);
                all_passed = 1'b0;  
            end else begin
                $display("PASS:  %0d %0d %0d = %0d", a, func, b, alu_result);
            end
        end
    endtask

    initial begin
        all_passed = 1'b1;  

        // 测试用例
        run_test(32'd10, 32'd5, 5'b00001, 32'd15);   // 10 + 5 = 15
        run_test(32'd20, 32'd30, 5'b00001, 32'd50);  // 20 + 30 = 50
        run_test(32'd50, 32'd20, 5'b00010, 32'd30);  // 50 - 20 = 30
        run_test(32'd10, 32'd15, 5'b00010, -32'd5);  // 10 - 15 = -5
        run_test(32'hFF00FF00, 32'h0F0F0F0F, 5'b00011, 32'h0F000F00);
        run_test(32'hFF00FF00, 32'h0F0F0F0F, 5'b00100, 32'hFF0FFF0F);
        run_test(32'd10, 32'd20, 5'b00101, 32'd1);  // 10 < 20 = 1
        run_test(32'd30, 32'd10, 5'b00101, 32'd0);  // 30 < 10 = 0
        run_test(-32'd5, 32'd3, 5'b00101, 32'd1);   //-5 < 3 = 1

     
       
        if (reset) begin
            result = 2'b00;
        end 
        if (all_passed) begin
            result = 2'b10; 
            $display("=== ALL TESTS PASSED ===");
        end else begin
            result = 2'b01; 
            $display("=== SOME TESTS FAILED ===");
        end
        $stop;
    end
   
endmodule

`endif
