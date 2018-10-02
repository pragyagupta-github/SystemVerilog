module fetch(
input bit clock, reset, br_taken, enable_updatepc, enable_fetch,
input bit [15:0] taddr,
output logic [15:0] pc,npc_out,
output logic instrmem_rd);


always@(posedge clock)
begin
   if(reset)
      begin
      pc<=16'h3000;
      npc_out<=16'h3001;
      end
   else 
      begin
             if(enable_updatepc)
               begin
                 if(br_taken)
                 pc<=taddr;
                 else
                 pc<=pc+1;
               end
             else
               begin
                pc<=pc;
                npc_out<=pc+1;
               end
      end
end


always@(posedge clock)
begin
if(!reset)
      begin
             if(enable_fetch)
             instrmem_rd<=1'b1;
             else
             instrmem_rd<=1'bz;
      end
  
   

end


endmodule
