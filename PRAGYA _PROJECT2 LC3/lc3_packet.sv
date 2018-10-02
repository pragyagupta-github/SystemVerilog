class lc3_packet;
rand bit complete_data, complete_instr;
rand logic [15:0] Instr_dout, Data_dout;
logic [15:0] pc, Data_addr, Data_din;
logic instrmem_rd, Data_rd, I_macc, D_macc;
bit reset;
constraint c2{ Instr_dout inside {[16'h0000:16'hffff]};
               Data_dout  inside {[16'h0000:16'hffff]};
               complete_data inside {1'b1,1'b0};
               complete_instr inside {1'b1,1'b0};}

function void post_randomize();
begin
$display(" post : %b(c_d), %b(c_i),%h(pc), %h(dout)", complete_data, complete_instr, pc, Data_dout);


end 
endfunction
endclass