module MUX_unit(

  input [7:0] rom,
  input [7:0] ram,
  input wire ch,
  output reg [7:0] out

);

always@(rom or ram)
begin
	if (ch)
		out <= ram;
	else
		out <= rom;
	
end
    
endmodule
