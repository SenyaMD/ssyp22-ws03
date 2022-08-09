module CMP_unit(
	input wire [7:0] n1,//, n2,
	output wire zero
//	output wire greater, equal, less
);
	assign zero = (n1 == 8'h00) ? 1 : 0;
/*	assign greater = (n1 > n2) ? 1 : 0;
	assign equal = (n1 == n2) ? 1 : 0;
	assign less = (n1 < n2) ? 1 : 0;*/
endmodule
