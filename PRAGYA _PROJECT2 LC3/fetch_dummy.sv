module fetch_dummy(clock, reset, enable_updatepc, enable_fetch, pc,npc_out, instrmem_rd, taddr, br_taken);
input enable_updatepc,clock, reset, br_taken, enable_fetch;
input [15:0] taddr;
output reg [15:0] pc, npc_out;
output instrmem_rd;
//reg [15:0]ipc;
wire [15:0]muxout;
wire [15:0] npc_int;

always @(posedge clock)
begin
	
	if(reset==1)
		pc<=16'h3000;
		
	else
	begin
		if(enable_updatepc)
		pc <= muxout;
		else
		pc <= pc;
	end
end
assign muxout = (br_taken==1) ? taddr : npc_int;
assign npc_int=pc+1;
assign npc_out = npc_int;
//assign pc = ipc;
assign instrmem_rd = (enable_fetch)?1'b1: 1'bz;
endmodule
