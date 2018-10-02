module fetch_tb;
 bit clock, reset;
logic br_taken, enable_updatepc, enable_fetch;
logic [15:0]taddr;
logic [15:0]pc, npc_out;
logic instrmem_rd;

fetch f1(.*);

initial
begin
clock = 1'b1;
forever #5 clock=~clock;
end

initial
begin
 reset     = 1'b0;
#500 reset = 1'b1;
#600 reset = 1'b0;
end

initial
begin
for(int j=0;j<500;j++)
taddr = $urandom_range(16'h3000,16'h5000);
#40;
end

initial
begin
	br_taken=1'b0;
        enable_updatepc =1'b1;
        enable_fetch=1'b1;
	#20;
	for(int i=0;i<100;i++)
	begin
		br_taken=~br_taken;
                #40;
		enable_updatepc=~enable_updatepc;
                #40;
                enable_fetch=~enable_fetch;
                #40;
                
               
	end
end
endmodule