`ifndef __ALU_SV
`define __ALU_SV

module alu
    (
        input logic[31:0] srca, srcb,
        input logic[4:0] alufunc,
        output logic[31:0] result
    );
    typedef enum logic[4:0] { 
        ADD = 5'b00001,
        SUB = 5'b00010,
        AND = 5'b00011,
        OR = 5'b00100,
        LESS = 5'b00101
    } ALU_Op;
   
    always_comb begin
        case(alufunc)
            ADD: result = srca + srcb;
            SUB: result = srca - srcb;
            LESS: result = $signed(srca) < $signed(srcb) ? 32'b1 : 32'b0;
            AND: result = srca & srcb;
            OR: result = srca | srcb;
            default: result = 32'b0;
        endcase
    end

endmodule

`endif
