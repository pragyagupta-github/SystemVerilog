class fetch_generator;
fetch_packet pkt;
mailbox #(fetch_packet) gen_drv;

function new(mailbox #(fetch_packet) gen_drv);
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