//checked - OK
module RAM_unit(
		input wire [7:0] A,
		output [7:0] D,
		input [7:0] Dd,
		input wire wr,
		output [7:0] PORTA,
		output [7:0] PORTB,
		output [7:0] PORTC,
		output [7:0] PORTD
	);
	reg [7:0] ram[255:0];
	initial
	begin
		$readmemh("RAM.dat", ram);
	end
	assign D = ram[A];
	
	always @(posedge wr)
		ram[A] <= Dd;
	
	assign PORTA = ram[8'hff];
	assign PORTB = ram[8'hfe];
	assign PORTC = ram[8'hfd];
	assign PORTD = ram[8'hfc];
	
endmodule
