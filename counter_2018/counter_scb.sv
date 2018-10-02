class counter_scb;
 counter_tx exp_tx,act_tx;
 counter_tx exp_tx1,act_tx1;
 counter_tx exp_txQ[$],act_txQ[$];
  task run();
    bit flag;
    $display("Counter::Scoreboard"); 
      fork
         forever begin 
           counter_cfg::mon2scb.get(exp_tx);
          // drive_refmod(exp_tx); 
           $display("******************Expected Transaction*******************");
           exp_txQ.push_back(exp_tx); 
	   exp_tx.print();
         end

         forever begin
           counter_cfg::mon2scb.get(act_tx);
           $display("------------------Actual Transaction---------------------");
           act_txQ.push_back(act_tx); 
           act_tx.print();
         end 

         forever begin
           wait((exp_txQ.size > 0) && (act_txQ.size > 0));
                act_tx1 = act_txQ.pop_front();
                exp_tx1 = exp_txQ.pop_front();
                flag = act_tx1.compare(exp_tx1);
                if(flag ==1) begin
       			$display("The transaction comparison failed");
		        $display("The act load = %h, exp load = %h ", act_tx1.load, exp_tx1.load);
		        $display("The act data = %h, exp data = %h ", act_tx1.d, exp_tx1.d);
		        $display("The act updown = %h, exp updown= %h ", act_tx1.updown, exp_tx1.updown);
		        $display("The act count = %h, exp count = %h ", act_tx1.count, exp_tx1.count);
     		end
     		else begin
       			$display("The transaction comparison success");
		        $display("The act load = %h, exp load = %h ", act_tx1.load, exp_tx1.load);
		        $display("The act data = %h, exp data = %h ", act_tx1.d, exp_tx1.d);
		        $display("The act updown = %h, exp updown= %h ", act_tx1.updown, exp_tx1.updown);
		        $display("The act count = %h, exp count = %h ", act_tx1.count, exp_tx1.count);
     		    end
	    end
    join
  endtask
  /*  task drive_refmod(counter_tx tx);
     if(tx.load == 1'b1)
       tx.count = tx.d;
     else if(tx.updown == 1'b1)
       tx.count = tx.count + 1'b1;
     else 
       tx.count = tx.count - 1'b1;
     end
    endtask*/
endclass
