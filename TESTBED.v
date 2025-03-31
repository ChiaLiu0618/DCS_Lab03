`timescale 1ns/10ps

`include "PATTERN.v"
`ifdef RTL
    `include "AutoPay.v"
`endif
`ifdef GATE
    `include "AutoPay_SYN.v"
`endif

module TESTBED;

wire         clk;
wire         rst_n;
wire         credit_valid;
wire [7:0]   credit;
wire         price_valid;
wire [5:0]   price;
wire         out_valid;
wire [8:0]   out_data;

initial begin
    `ifdef RTL
        $fsdbDumpfile("AutoPay.fsdb");
        $fsdbDumpvars(0,"+mda");
    `endif
    `ifdef GATE
        $sdf_annotate("AutoPay_SYN.sdf", u_AutoPay);
        $fsdbDumpfile("AutoPay_SYN.fsdb");
        $fsdbDumpvars(0,"+mda"); 
    `endif
end

AutoPay u_AutoPay(
    .clk			(clk			),
    .rst_n			(rst_n			),
    .credit_valid	(credit_valid	),
    .credit			(credit			),
    .price_valid	(price_valid	),
    .price			(price			),
    .out_valid		(out_valid		),
    .out_data		(out_data		)
);
    
PATTERN u_PATTERN(
    .clk			(clk			),
    .rst_n			(rst_n			),
    .credit_valid	(credit_valid	),
    .credit			(credit			),
    .price_valid	(price_valid	),
    .price			(price			),
    .out_valid		(out_valid		),
    .out_data		(out_data		)
);

endmodule
