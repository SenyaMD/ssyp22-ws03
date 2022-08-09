//checked - OK
module and_unit(
	input wire [7:0] inp_0,
	input wire [7:0] inp_1,
	output wire [7:0] out);
  assign out = inp_0 & inp_1;
endmodule
