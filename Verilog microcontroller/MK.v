module microcontroller(
    input wire clk,
    input wire int,
    output wire[7:0] PORTA,
    output wire[7:0] PORTB,
    output wire[7:0] PORTC,
    output wire[7:0] PORTD
);
    wire writePC;
    wire [7:0] wPC;
    wire [7:0] PC;
    wire [11:0] rom_data;
    wire [7:0] ram_data;
    wire writeRAM;
    wire mux_channel;
    wire [7:0]mux_out;
    wire [7:0] alu_res;
    wire alu_ovf;
    wire [7:0] acc_out;
    wire zero;
    wire bnk;
    wire [3:0]flags;
    wire [3:0] s;
    wire [3:0] rev;
    PC_unit programm_counter(clk, writePC, wPC, PC);
    ROM_unit rom(PC, rom_data);
    RAM_unit ram(rom_data[11:4], ram_data, acc_out, writeRAM, PORTA, PORTB, PORTC, PORTD);
    MUX_unit mux(rom_data[11:4], ram_data, mux_channel, mux_out);
    ALU_unit alu(acc_out, mux_out, rom_data[3:0], alu_res, alu_ovf);
    ACC_unit acc(alu_res, acc_out, clk);
    CMP_unit cmp(acc_out, zero);
    flags_unit flags_reg({alu_ovf, zero, int, bnk}, rev, flags);
    control_unit control(clk, rom_data[3:0], rom_data[11:4], flags, PC, wPC, rev, writeRAM, writePC);
endmodule
