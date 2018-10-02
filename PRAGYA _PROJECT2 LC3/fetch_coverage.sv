class fetch_coverage;
virtual fetch_intf i;

covergroup cg@(posedge i.clock);
taddr        :coverpoint i.taddr{bins t={[16'h3000:16'h4efb]};}
br_taken     :coverpoint i.br_taken;
updatepc     :coverpoint i.enable_updatepc;
reset        :coverpoint i.reset;
enable_fetch :coverpoint i.enable_fetch;
pc           :coverpoint i.pc{bins out1={[16'h3000:16'h4efc]};}
npc_out      :coverpoint i.npc_out{bins out2={[16'h3001:16'h4efd]};}
instrmem_rd  :coverpoint i.instrmem_rd{bins d1={1'bz}; bins d2={1'b1};}
endgroup

function new(virtual fetch_intf i);
this.i=i;
cg=new();
endfunction

task sample();
cg.sample();
endtask
endclass
