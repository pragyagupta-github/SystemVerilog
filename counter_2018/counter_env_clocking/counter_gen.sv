class counter_gen;
 counter_tx tx;

 task run();
  $display("This is COUNTER Generator module");
  case(counter_cfg::testcase)
   "counter_up_test":begin
   			for(int i=0;i<16;i++) begin
   		 	tx = new();
  			tx.randomize() with {tx.updown==1'b1;tx.load==1'b0;};
  			counter_cfg::gen2bfm.put(tx);
			//tx.print();  
                        end
	             end
   "counter_down_test":begin
   			for(int i=0;i<16;i++) begin
   		 	tx = new();
  			tx.randomize() with {tx.updown==1'b0;tx.load==1'b0;};
  			counter_cfg::gen2bfm.put(tx);
	              end
		     end
  "counter_load_test":begin
                        tx = new();
  			tx.randomize() with {tx.load==1'b1;};
  			counter_cfg::gen2bfm.put(tx);
		      end
           endcase
   endtask
endclass
