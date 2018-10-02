class lc3_generator;
lc3_packet pkt;
mailbox #(lc3_packet) gen_drv;

function new(mailbox #(lc3_packet) gen_drv);
this.gen_drv=gen_drv;
endfunction

task run;
pkt=new();
assert(pkt.randomize())
begin
$display("success");
gen_drv.put(pkt);
end
else
$error("randomization failed");
endtask
endclass