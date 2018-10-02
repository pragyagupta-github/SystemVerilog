class lc3_scoreboard;
fetch_packet fpkt;
mailbox #(fetch_packet) mon_sb;

function new(mailbox #(fetch_packet)mon_sb);
this.mon_sb=mon_sb;
endfunction

reg [15:0] pc, npc_out;
reg instrmem_rd;

task run;
mon_sb.get(fpkt);
pc=16'h3000;
npc_out= pc +1'b1;
begin
   if(fpkt.enable_updatepc)
               begin
                  if(fpkt.br_taken)
                  begin 
                  pc<= fpkt.taddr;
                  npc_out<=npc_out+1;
                  end
                  else
                  begin
                  pc<=npc_out;
                  npc_out<=pc+1;
                  end


                      assert (fpkt.pc == pc)
                      $display("success for pc %b and fetch %b",pc, fpkt.pc);
                      else
                      $error("fail"); 
                     
                      assert(fpkt.npc_out==npc_out)
                      $display("success for npc_out %b and fetch %b", npc_out, fpkt.npc_out);
                      else
                      $error("failed");
               end

end

begin
if(fpkt.enable_fetch) 
     instrmem_rd=1'b1;
     else
    instrmem_rd= 1'bz;
     begin
             assert(fpkt.instrmem_rd==instrmem_rd)
             $display("success for instrmem_rd %b and fetch %b",instrmem_rd, fpkt.instrmem_rd);
             else
             $error("mismatch for instrmem_rd");
             end
     end
//$display(" FPKT DISPLAY  : %b", fpkt.complete_data);
endtask
endclass



