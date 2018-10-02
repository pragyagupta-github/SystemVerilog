class fetch_environment;
mailbox #(fetch_packet) gen_drv;
mailbox #(fetch_packet) mon_sb;
virtual fetch_intf i;
virtual fetch_intf j;
fetch_generator g1;
fetch_driver d1;
fetch_coverage c1;
fetch_monitor m1;
fetch_scoreboard s1;

function new(virtual fetch_intf i, virtual fetch_intf j);
this.i=i;
this.j=j;
endfunction

function build;
gen_drv=new();
mon_sb=new();
g1=new(gen_drv);
d1=new(gen_drv,  i,j);
c1=new(i);
m1=new(mon_sb, i,j);
s1=new(mon_sb);
endfunction

task run;
g1.run;
d1.run;
c1.sample();
m1.run;
s1.run;
endtask
endclass