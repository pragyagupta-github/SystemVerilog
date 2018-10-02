class lc3_driver;
lc3_packet pkt;
mailbox #(lc3_packet) gen_drv;
virtual lc3_intf l;

function new(mailbox #(lc3_packet) gen_drv, virtual lc3_intf l);
this.gen_drv=gen_drv;
this.l=l;
endfunction

task run;
pkt=new();
gen_drv.get(pkt);

l.complete_data        = pkt.complete_data;
l.complete_instr       = pkt.complete_instr;
l.Instr_dout           = pkt.Instr_dout;
l.Data_dout            = pkt.Data_dout;
endtask
endclass