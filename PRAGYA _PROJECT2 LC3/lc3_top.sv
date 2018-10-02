`include "lc3_packet.sv"
`include "fetch_packet.sv"
`include "lc3_generator.sv"
`include "lc3_driver.sv"
`include "lc3_intf.sv"
`include "fetch_intf.sv"

`include "fetch_dummy.sv"
`include "decode.sv"
`include "Execute.sv"
`include "Writeback.sv"
`include "MemAccess.sv"
`include "Controller_Pipeline.sv"
`include "LC3.sv"

`include "lc3_coverage.sv"
`include "fetch_coverage.sv"

`include "lc3_monitor.sv"
`include "lc3_scoreboard.sv"
`include "lc3_environment.sv"
`include "lc3_test.sv"

module lc3_top;
logic clock, reset;

lc3_intf l(clock,reset);

LC3 dut(.clock(clock), .reset(reset), .complete_data(l.complete_data), .complete_instr(l.complete_instr), .Instr_dout(l.Instr_dout) , .Data_dout(l.Data_dout), .pc(l.pc), .Data_addr(l.Data_addr), .Data_din(l.Data_din), .instrmem_rd(l.instrmem_rd), .Data_rd(l.Data_rd), .I_macc(l.I_macc), .D_macc(l.D_macc));

fetch_intf fi(.br_taken(dut.Fetch.br_taken), .enable_updatepc(dut.Fetch.enable_updatepc), .enable_fetch(dut.Fetch.enable_fetch), .taddr(dut.Fetch.taddr), .clock(clock), .reset(reset), .pc(dut.Fetch.pc), .npc_out(dut.Fetch.npc_out), .instrmem_rd(dut.Fetch.instrmem_rd));

initial
begin
clock =1'b1;
forever #5 clock=~clock;
end

initial
begin
reset =1'b1;
#1000 reset = 1'b0;
#600 reset = 1'b1;
#500 reset =1'b0;

end
lc3_test t1(l,fi);
endmodule