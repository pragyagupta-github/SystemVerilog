class counter_cov;
 counter_tx tx;
  event tx_e;

covergroup counter_cg@(tx_e);
   counter_load_CP: coverpoint tx.load {bins load_bin = {0,1};} 
   counter_updown_CP: coverpoint tx.updown {bins updown = {0,1};}
   counter_data_CP: coverpoint tx.d {bins data = {[0:15]};}
   counter_count_CP: coverpoint tx.count { bins count_bin1 = {0};
					   bins count_bin2 = {1};
					   bins count_bin3 = {2};
					   bins count_bin4 = {3};
					   bins count_bin5 = {4};
					   bins count_bin6 = {5};
					   bins count_bin7 = {6};
					   bins count_bin8 = {7};
					   bins count_bin9 = {8};
					   bins count_bin10 = {9};
					   bins count_bin11 = {10};
					   bins count_bin12 = {11};
					   bins count_bin13 = {12};
					   bins count_bin14 = {13};
					   bins count_bin15 = {14};
					   bins count_bin16 = {15};
					   
					 }
 endgroup 

 function new();
    counter_cg = new(); // covergroup instantiated
 endfunction


   task run();
     forever begin
        counter_cfg::mon2cov.get(tx);
	$display("I am in the coverage class");
        //tx.print(); 
        -> tx_e;
      end
   endtask
endclass
