interface fetch_intf(
input bit clock, reset,
input logic br_taken, enable_updatepc, enable_fetch,
input logic [15:0] taddr,
input logic [15:0] pc,
input logic [15:0] npc_out,
input logic instrmem_rd);

 assert property (@(posedge clock) (enable_fetch)|->  (instrmem_rd));

assert property (@(posedge clock) (enable_updatepc)|=> (pc));

assert property (@(posedge clock) (br_taken)|=> (npc_out));
endinterface