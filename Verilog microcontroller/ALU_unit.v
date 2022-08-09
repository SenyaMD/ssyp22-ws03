//checked - OK.
module ALU_unit(
	input wire [7:0] inp_0,
	input wire [7:0] inp_1, 
	input wire [3:0] sel,
	output reg [7:0] res,
	output wire c_out);
	wire[7:0] and_out, not_out, or_out, sum_out, xor_out;
	and_unit gand(inp_0, inp_1, and_out);
	not_unit gnot(inp_1, not_out);
	or_unit gor(inp_0, inp_1, or_out);
	sum_unit gsum(inp_0, inp_1, sum_out, c_out);
	xor_unit gxor(inp_0, inp_1, xor_out);
	
	always@ (inp_0 or inp_1 or sel)
		case(sel)
			4'h0: res <= inp_0;		 //NOP(проброс значения из аккумулятора)
			4'h1: res <= inp_1;
			4'h2: res <= inp_1;
			4'h3: res <= and_out;	//AND
			4'h4: res <= or_out;	//OR
			4'h5: res <= xor_out; 	//XOR
			4'h6: res <= not_out;	//NOT
			4'h7: res <= inp_0;
			4'h8: res <= inp_0;
			4'h9: res <= inp_0;
			4'ha: res <= inp_0;
			4'hb: res <= sum_out;	//ADD
			4'hc: res <= inp_0;
			4'hd: res <= inp_0;
			4'he: res <= inp_0;
			4'hf: res <= inp_0;
		endcase
	
endmodule
