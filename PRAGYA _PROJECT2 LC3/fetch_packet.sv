class fetch_packet;
logic br_taken, enable_updatepc, enable_fetch;
logic [15:0] taddr;
logic [15:0] pc,npc_out;
logic instrmem_rd;
logic reset;
/*constraint c1{taddr inside {[16'h3000:16'h5000]};
              br_taken inside {1'b1,1'b0};
              enable_updatepc inside {1'b1,1'b0};
              enable_fetch inside {1'b1,1'b0};}*/
             
endclass