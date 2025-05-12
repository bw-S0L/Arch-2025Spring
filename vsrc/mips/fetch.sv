`ifndef __FETCH_SV
`define __FETCH_SV

module fetch
    import common::*;
    import pipes::*;(
        
    );

endmodule

/* maybe userful */
module pcselect
    import common::*;
    import pipes::*;(
        input u1 clk, reset,
        input u32 pc_plus,
        input u32 jump_addr,
        input u1 jump,
        output u32 pc_selected
    );

endmodule

`endif
