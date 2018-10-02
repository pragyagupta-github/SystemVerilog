class counter_drv;
 counter_tx tx,tx1,tx2,tx3;
 virtual counter_if.BFM vif;

 task run();
  $display("This is COUNTER Driver module");
  vif = counter_cfg::vif;
  @(posedge vif.rst); //Wait for Dut to comeout of reset
  forever begin
    counter_cfg::gen2bfm.get(tx);
    drive_dut(tx);
   end
 endtask
 

 task drive_dut(counter_tx tx);
   @(negedge vif.cb);
     if(tx.load==1'b1)
        begin
          vif.cb.load <= tx.load;
          vif.cb.d  <= tx.d;
           @(posedge vif.cb);
           @(negedge vif.cb);
	    vif.cb.load <= 1'b0;
            vif.cb.updown <= tx.updown;	
       end
     else if(tx.updown == 1'b1 && tx.load == 1'b0)
        begin
         vif.cb.updown <= tx.updown;
        end
     else if(tx.updown == 1'b0 && tx.load == 1'b0)
        begin
         vif.cb.updown <= tx.updown;
        end
     else
	begin 
         vif.cb.d  <= tx.d;
         vif.cb.load <= tx.load;
         vif.cb.updown <= tx.updown;
         
  	end
  endtask

endclass
