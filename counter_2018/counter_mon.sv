class counter_mon;
 counter_tx tx,tx1;
 virtual counter_if vif;
 virtual counter_rif rif;

 task run();
   $display("counter_mon:run task");
   vif = counter_cfg::vif;
   rif = counter_cfg::rif;
fork
 forever begin
   @(posedge vif.clk);
    if(vif.load == 1'b1 || vif.updown == 1'b1 ||vif.updown == 1'b0 )
      begin
        tx=new();
        tx.load = vif.load;
	tx.updown = vif.updown;
	tx.d     = vif.d;
	tx.count = vif.count;
        counter_cfg::mon2cov.put(tx);
        counter_cfg::mon2scb.put(tx);
      end
   end
forever begin
   @(posedge rif.clk);
    if(rif.load == 1'b1 || rif.updown == 1'b1 ||rif.updown == 1'b0 )
      begin
        tx1=new();
        tx1.load = rif.load;
	tx1.updown = rif.updown;
	tx1.d     = rif.d;
	tx1.count = rif.count;
        counter_cfg::mon2cov.put(tx1);
        counter_cfg::mon2scb.put(tx1);
      end
   end

join
 endtask
endclass
