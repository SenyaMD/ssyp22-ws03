module control_unit(
	input wire clock,
	input wire [3:0] command,
	input wire [7:0] data,
	input wire [3:0] FR,
	input wire [7:0] PC_in,
	output reg [7:0] PC_out,
	output reg [3:0] FR_rev,
	output reg RAM_w, PC_w
);
	reg [7:0] int_adr;
	reg [3:0] st_adress;
	reg [7:0] stack[3:0];
	reg IE; // Internet Explorer
	initial begin
		st_adress = 4'h0;
		IE = 0;
	end
	always @(negedge clock) begin
		RAM_w <= 1'h0;
		PC_w <= 1'h0;
		FR_rev <= 4'h0;
	end
	always @(posedge clock) begin
		if (FR[2]) begin
			if (IE) begin
				stack[st_adress] <= PC_in;
				st_adress <= st_adress + 1;
				PC_out <= data;
				PC_w <= 1;
			end
		end
		else case (command)
				// STO
				4'h7: RAM_w <= 1;
				// JMP
				4'h8: begin
					PC_out <= data;
					PC_w <= 1;
				end
				// JMPZ
				4'h9: if (FR[1]) begin
						PC_out <= data;
						PC_w <= 1;
					end
				// JMPO
				4'hA: if (FR[0]) begin
						PC_out <= data;
						PC_w <= 1;
					end
				// SEI
				4'hC: begin
					IE <= 1;
					st_adress <= data;
				end
				// INVB
				4'hD: FR_rev <= (4'h1 << data);
				// CALL
				4'hE: begin
					stack[st_adress] <= PC_in;
					st_adress <= st_adress + 1;
					PC_out <= data;
					PC_w <= 1;
				end
				// RET
				4'hF: begin
					st_adress <= st_adress - 1;
					PC_out <= stack[st_adress];
					PC_w <= 1;
				end
			endcase
	end
endmodule
