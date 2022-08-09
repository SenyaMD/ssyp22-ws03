module trigger(
	input wire s,
	input wire rev,
	output reg Q);
	always@ (s or rev)
	if (s == rev)
		Q = 0;
	else
		Q = 1;
endmodule
