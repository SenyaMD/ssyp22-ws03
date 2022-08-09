//checked - OK
module PC_unit(
  input wire clock,
  input wire write,
  input wire [7:0] wdata,
  output reg [7:0] count
);

  reg[7:0] next;

  initial
  begin
	count <= 8'h00;
	next <= 8'h01;
  end

  always @(posedge write)
    next <= wdata;

  always @(posedge clock)
  begin
      count <= next;
      next <= next + 8'h01;
  end

endmodule
