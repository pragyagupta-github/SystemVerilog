class lc3_environment;
mailbox #(lc3_packet) gen_drv;
mailbox #(fetch_packet) mon_sb;
virtual lc3_intf l;
virtual fetch_intf fi;

lc3_generator g1;
lc3_driver d1;
lc3_coverage c3;
fetch_coverage c2;
lc3_monitor m1;
lc3_scoreboard s1;


function new(virtual lc3_intf l, virtual fetch_intf fi);
this.l=l;
this.fi=fi;
endfunction

function build;
gen_drv=new();
mon_sb=new();
g1=new(gen_drv);
d1=new(gen_drv, l);
c2=new(fi);
c3=new(l);
m1=new(mon_sb, l, fi);
s1=new(mon_sb);
endfunction

task run;
g1.run;
d1.run;
c2.sample();
c3.sample();
m1.run;
s1.run;
endtask
endclass