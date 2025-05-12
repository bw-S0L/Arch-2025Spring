`ifndef __CORE_SV
`define __CORE_SV

module core
    import common::*;
    import pipes::*;(
        input logic clk, reset,
        /* instruction memory */
        output u32 instr_addr,
        input u32 instruction,
        /* data memory */
        output u32 data_addr,
        input word_t read_data,
        output word_t write_data,
        output u1 write_enable
    );
    
    /* instruction */
    u32 pc, pc_next;
    assign instr_addr = pc;

    /* TODO: add your design here. */

    /* Don't forget to drive the output signal. */

    /* TODO: wire the regfile */
    regfile regfile(
        .clk(clk), .reset(reset),
        .ra1(), .ra2(),
        .rd1(), .rd2(),
        .wa(),
        .wd(),
        .we()
    );

endmodule

`endif
