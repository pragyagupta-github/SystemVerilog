class lc3_coverage;
virtual lc3_intf l;

covergroup cg@(posedge l.clock);
Instr_dout        :coverpoint l.Instr_dout;
//{bins t={[16'h0000:16'h7000]}; bins t2={16'ha000}; bins t3={16'hb000};bins t4={16'h9bbb};bins t5={16'h8aaa};}
Data_dout         :coverpoint l.Data_dout {bins t1={[16'h0000:16'h9fff]};}
complete_data     :coverpoint l.complete_data;
complete_instr    :coverpoint l.complete_instr;
reset             :coverpoint l.reset;
pc                :coverpoint l.pc {bins out1={[16'h3000:16'hafff]};}
Data_din          :coverpoint l.Data_din{bins out3={[16'h0000:16'hafff]};}
Data_addr         :coverpoint l.Data_addr{bins out2={[16'h3001:16'hafff]};}
instrmem_rd       :coverpoint l.instrmem_rd{bins c1={1'bz}; bins c2={1'b1};}
I_macc            :coverpoint l.I_macc;
//D_macc            :coverpoint l.D_macc;
data              :cross l.complete_data, l.complete_instr;
endgroup

function new(virtual lc3_intf l);
this.l=l;
cg=new();
endfunction

task sample();
cg.sample();
endtask
endclass