class fetch_scoreboard;
fetch_packet pkt1;
fetch_packet pkt2;
mailbox #(fetch_packet) mon_sb;

function new(mailbox #(fetch_packet) mon_sb);
this.mon_sb=mon_sb;
endfunction

task run;
mon_sb.get(pkt1);
$display(" GETTING FROM dRIVER TO SB %p", pkt1);
mon_sb.get(pkt2);
$display(" GETTING FROM MONITOR TO SB %p", pkt2);

begin
assert((pkt1.pc==pkt2.pc) && (pkt1.npc_out==pkt2.npc_out) &&(pkt1.instrmem_rd==pkt2.instrmem_rd))
begin
$display("success: match");
end
else
$error("failed");
end
$display($time,"pc (driver)=%b, npc(driver)=%b, instrmem_rd (driver)=%b, pc (monitor)=%b, npc(monitor)=%b, instrmem_rd (monitor)=%b", pkt1.pc, pkt1.npc_out, pkt1.instrmem_rd, pkt2.pc, pkt2.npc_out, pkt2.instrmem_rd);
endtask
endclass