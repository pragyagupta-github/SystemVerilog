`include "fetch_packet.sv"
`include "fetch_generator.sv"
`include "fetch_driver.sv"
`include "fetch_intf.sv"
`include "fetch_coverage.sv"
`include "fetch.sv"
`include "fetch_dummy.sv"
`include "fetch_monitor.sv"
`include "fetch_scoreboard.sv"
`include "fetch_environment.sv"
`include "fetch_test.sv"

module fetch_top(input bit clock,reset);

fetch_intf i(clock,reset);
fetch_intf j(clock,reset);

initial
begin
clock=1'b1;
forever #5 clock=~clock;
end

initial
begin
reset=1'b0;
#500 reset=1'b1;
#600 reset=1'b0;
end
fetch a2(.clock(i.clock), .reset(i.reset), .br_taken(i.br_taken) , .taddr(i.taddr),  .enable_updatepc(i.enable_updatepc),  .enable_fetch(i.enable_fetch), .pc(i.pc), .npc_out(i.npc_out), .instrmem_rd(i.instrmem_rd));
fetch_dummy a1(.clock(j.clock), .reset(j.reset), .br_taken(j.br_taken) , .taddr(j.taddr),  .enable_updatepc(j.enable_updatepc),  .enable_fetch(j.enable_fetch), .pc(j.pc), .npc_out(j.npc_out), .instrmem_rd(j.instrmem_rd));
fetch_test t1(i,j);
endmodule