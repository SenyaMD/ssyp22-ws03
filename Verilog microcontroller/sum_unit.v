//Checked - OK
module sum_unit(inp_0, inp_1, out_0, out_1);
  input [7:0] inp_0;
  input [7:0] inp_1;
  output [7:0] out_0;
  output out_1;
  assign {out_1, out_0} = inp_0 + inp_1;
endmodule
