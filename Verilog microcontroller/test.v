`timescale 1ns/1ns

module test;
	reg clk;
	reg int;
	input wire[7:0] PORTA;
    input wire[7:0] PORTB;
    input wire[7:0] PORTC;
    input wire[7:0] PORTD;
	microcontroller MK(clk, int, PORTA, PORTB, PORTC, PORTD);

	always
		#10 clk = ~clk;
		
	initial
	begin
		clk = 0;
		int = 0;
		
		#1000;
		
		@(posedge clk)
			int = 1;
		
		@(posedge clk)
			int = 0;

	end
	
	initial
	begin
		#1000 $finish;
	end
	
	initial
	begin
		$dumpfile("out.vcd");
		$dumpvars(0, test);
	end
	
	//initial
	//	$monitor($stime,, reset,, clk,, write,, wPC,, PC);
	
endmodule
