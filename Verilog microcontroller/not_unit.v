module not_unit(
	input wire [7:0] inp,
	output wire [7:0] out);
  assign out = ~inp;
endmodule
