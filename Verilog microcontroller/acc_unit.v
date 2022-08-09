//checked - OK
module ACC_unit(
	input wire [7:0] in,
	output reg [7:0] out,
	input wire wr
);

always @(negedge wr)
begin
	out <= in;
end

endmodule
