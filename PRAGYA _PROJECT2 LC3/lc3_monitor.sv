class lc3_monitor;
lc3_packet pkt;
fetch_packet fpkt;
mailbox #(fetch_packet) mon_sb;
virtual lc3_intf l;
virtual fetch_intf fi;

function new(mailbox #(fetch_packet) mon_sb, virtual lc3_intf l,virtual fetch_intf fi);
this.mon_sb=mon_sb;
this.l=l;
this.fi=fi;
endfunction

task run;
pkt=new();
fpkt=new();

fpkt.br_taken         = fi.br_taken;
fpkt.enable_updatepc  = fi.enable_updatepc;
fpkt.enable_fetch     = fi.enable_fetch;
fpkt.taddr            = fi.taddr;
fpkt.pc               = fi.pc;
fpkt.npc_out          = fi.npc_out;
fpkt.instrmem_rd      = fi.instrmem_rd;

pkt.complete_data     = l.complete_data;
pkt.complete_instr    = l.complete_instr;
pkt.Instr_dout        = l.Instr_dout;
pkt.Data_dout         = l.Data_dout;
pkt.pc                = l.pc;
pkt.Data_addr         = l.Data_addr;
pkt.instrmem_rd       = l.instrmem_rd;
pkt.Data_din          = l.Data_din;
pkt.Data_rd           = l.Data_rd;
pkt.I_macc            = l.I_macc;
pkt.D_macc            = l.D_macc;

mon_sb.put(fpkt);
$display(" FROM MONITOR %p",fpkt);
/*mon_sb.put(pkt);
$display(" from monitor %p", pkt);*/
endtask
endclass
