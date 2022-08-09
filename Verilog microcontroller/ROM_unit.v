//checked - OK
module ROM_unit(
	input wire [7:0] A,
	output wire [11:0]D);
	reg [11:0] rom[255:0];
	initial
		$readmemh("ROM.dat", rom);
	assign D = rom[A];
endmodule
