class fetch_driver;
fetch_packet pkt;
mailbox #(fetch_packet) gen_drv;
virtual fetch_intf i;
virtual fetch_intf j;

function new(mailbox #(fetch_packet) gen_drv, virtual fetch_intf i, virtual fetch_intf j);
this.gen_drv=gen_drv;
this.i=i;
this.j=j;
endfunction

task run;
gen_drv.get(pkt);

i.br_taken        = pkt.br_taken;
i.taddr           = pkt.taddr;
i.enable_updatepc = pkt.enable_updatepc;
i.enable_fetch    = pkt.enable_fetch;

j.br_taken        = pkt.br_taken;
j.taddr           = pkt.taddr;
j.enable_updatepc = pkt.enable_updatepc;
j.enable_fetch    = pkt.enable_fetch;

endtask
endclass