class counter_drv;
 counter_tx tx,tx1,tx2;
 virtual counter_if vif;
 virtual counter_rif rif;

 task run();
  $display("This is COUNTER Driver module");
  vif = counter_cfg::vif;
  rif = counter_cfg::rif;
  @(negedge vif.rst); //Wait for Dut to comeout of reset
  forever begin
    counter_cfg::gen2bfm.get(tx);
        tx1 =  tx;
        tx2 =  tx;
      fork 
        drive_dut(tx1);
        drive_dummy(tx2);
      join
    //tx.print();
  end
 endtask

 task drive_dut(counter_tx tx);
   @(negedge vif.clk);
     if(tx.load==1'b1)
        begin
          vif.load <= tx.load;
          vif.d  <= tx.d;
           @(posedge vif.clk);
           @(negedge vif.clk);
	    vif.load <= 1'b0;
            vif.updown <= tx.updown;	
       end
     else if(tx.updown == 1'b1 && tx.load == 1'b0)
        begin
         vif.updown <= tx.updown;
        end
     else if(tx.updown == 1'b0 && tx.load == 1'b0)
        begin
         vif.updown <= tx.updown;
        end
     else
	begin 
         vif.d  <= tx.d;
         vif.load <= tx.load;
         vif.updown <= tx.updown;
         vif.count <= tx.count; 
  	end
 endtask

task drive_dummy(counter_tx tx);
   @(negedge rif.clk);
     if(tx.load==1'b1)
        begin
          rif.load <= tx.load;
          rif.d  <= tx.d;
           @(posedge rif.clk);
           @(negedge rif.clk);
	    rif.load <= 1'b0;
            rif.updown <= tx.updown;	
       end
     else if(tx.updown == 1'b1 && tx.load == 1'b0)
        begin
         rif.updown <= tx.updown;
        end
     else if(tx.updown == 1'b0 && tx.load == 1'b0)
        begin
         rif.updown <= tx.updown;
        end
     else
	begin 
         rif.d  <= tx.d;
         rif.load <= tx.load;
         rif.updown <= tx.updown;
         rif.count <= tx.count; 
  	end
 endtask

endclass
