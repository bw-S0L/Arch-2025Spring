`ifndef __TOP_SV
`define __TOP_SV

module Top
    import common::*;(
        input logic clk, reset,
        output u2 result
    );
    
    u32 pc, instruction, data_addr;
    word_t read_data, write_data;
    u1 write_enable;
    
    /* clock */
    logic clk_25MHz;
    clk_wiz_0 clk_wiz_inst (
        .clk_in1(clk),
        .clk_out1(clk_25MHz),
        .reset(reset)
    );

    /* instantiate a core */
    core core(
        .clk(clk_25MHz), .reset(reset),
        .instr_addr(pc), .instruction(instruction),
        .data_addr(data_addr), .write_enable(write_enable),
        .read_data(read_data), .write_data(write_data)
    );

    /* instantiate imem and dmem */
    imem imem(
        .pc(pc),
        .instruction(instruction)
    );
    dmem dmem(
        .clk(clk_25MHz),
        .we(write_enable),
        .addr(data_addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // for test
    logic [1:0] prev_result;

    always_ff @(posedge clk_25MHz) begin
        if (reset) begin
            result <= 2'b00;
            prev_result <= 2'b00;
        end 
        else begin
            if (prev_result == 2'b10 || prev_result == 2'b01) begin
                result <= prev_result;
            end 
            else begin
                case (pc)
                    PC_SUCCESS: begin
                        result <= 2'b10;
                    end
                    PC_FAILED1, PC_FAILED2, PC_FAILED3: begin
                        result <= 2'b01;
                    end
                    default: begin
                        result <= 2'b00;
                    end
                endcase
                prev_result <= result;
            end
        end
    end
    
endmodule

`endif
