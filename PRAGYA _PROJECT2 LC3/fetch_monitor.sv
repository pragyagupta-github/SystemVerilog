class fetch_monitor;
fetch_packet pkt1;
fetch_packet pkt2;
mailbox #(fetch_packet) mon_sb;
virtual fetch_intf i;
virtual fetch_intf j;

function new(mailbox #(fetch_packet) mon_sb, virtual fetch_intf i,virtual fetch_intf j);
this.mon_sb=mon_sb;
this.i=i;
this.j=j;
endfunction

task run;
pkt1=new();
pkt2=new();

pkt1.br_taken         = i.br_taken;
pkt1.enable_updatepc  = i.enable_updatepc;
pkt1.enable_fetch     = i.enable_fetch;
pkt1.taddr            = i.taddr;
pkt1.pc               = i.pc;
pkt1.npc_out          = i.npc_out;
pkt1.instrmem_rd      = i.instrmem_rd;

pkt2.br_taken         = j.br_taken;
pkt2.enable_updatepc  = j.enable_updatepc;
pkt2.enable_fetch     = j.enable_fetch;
pkt2.taddr            = j.taddr;
pkt2.pc               = j.pc;
pkt2.npc_out          = j.npc_out;
pkt2.instrmem_rd      = j.instrmem_rd;

mon_sb.put(pkt1);
$display(" FROM MONITOR %p",pkt1);
mon_sb.put(pkt2);
$display("FROM MONITOR FOR PKT2 %p",pkt2);
endtask
endclass