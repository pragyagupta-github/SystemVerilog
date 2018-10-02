class counter_mon;
 counter_tx tx;
 virtual counter_if.MON vif;

 task run();
   $display("counter_mon:run task");
   vif = counter_cfg::vif;
 forever begin
   @(posedge vif.clk);
    if(vif.load == 1'b1 || vif.updown == 1'b1 ||vif.updown == 1'b0 )
      begin
        tx=new();
        tx.load = vif.load;
	tx.updown =vif.updown;
	tx.d     = vif.d;
	tx.count = vif.count;
        
        tx.print();
      counter_cfg::mon2cov.put(tx);
      end
   end
 endtask
endclass
