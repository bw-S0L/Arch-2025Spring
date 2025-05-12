`ifndef __REGFILE_SV
`define __REGFILE_SV

module regfile
    import common::*;
    import pipes::*;(
        input logic clk, reset,
        // read ports
        input creg_addr_t ra1, ra2,
        output word_t rd1, rd2,
        // write port
        input creg_addr_t wa,
        input word_t wd,
        input logic we
    );
    word_t [31:0] regs, regs_nxt;

    // assign
    assign rd1 = (ra1 == 0) ? '0 : regs[ra1];
    assign rd2 = (ra2 == 0) ? '0 : regs[ra2];

    // posedge
    always_ff @(posedge clk) begin
        if (reset) begin
            regs <= '0;
        end
        else begin
            regs <= regs_nxt;
        end
    end

    // set regs nxt
    always_comb begin
        regs_nxt = regs; // default copy
        if (we && (wa != 0)) begin // wa == 0 is not writable
            regs_nxt[wa] = wd;
        end
    end
    
endmodule

`endif
