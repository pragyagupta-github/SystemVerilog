interface lc3_intf(input clock, reset);

bit complete_data, complete_instr;
logic [15:0] Instr_dout, Data_dout;
logic [15:0] pc, Data_addr, Data_din;
logic instrmem_rd, Data_rd, I_macc, D_macc;

modport drv(output complete_data, complete_instr,Instr_dout, Data_dout );
modport mon(input pc, Data_addr, Data_din, instrmem_rd, Data_rd, I_macc, D_macc);

assert property (@(posedge clock) (Instr_dout)|-> (pc));

endinterface