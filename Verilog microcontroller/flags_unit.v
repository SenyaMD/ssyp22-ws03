module flags_unit(
	input wire [3:0] s,
	input wire [3:0] rev,
	output wire [3:0] flag
);
	trigger ovf(s[0], rev[0], flag[0]);
	trigger cmp(s[1], rev[1], flag[1]);
	trigger int(s[2], rev[2], flag[2]);
	trigger bnk(s[3], rev[3], flag[3]);
endmodule
