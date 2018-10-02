module top;
reg clk,rst;

//Clock generation

initial begin 
  clk = 1'b0;
forever #5 clk = ~clk;
end
//Reset generation
 initial 
  begin
  @(negedge clk)
   rst = 1'b1;
  #10;
  @(negedge clk);
  @(negedge clk)
   rst = 1'b0;
  end

//Interface instantiation
 counter_if inf(clk,rst);

//DUT Instantiation synthesizable 
 counter DUT(inf);

//Virtual Interface connection to physical interface

  initial
   begin  
     counter_cfg::vif = inf;
   end

//TB Instantiation

  tb_top counter_tb_top();

// Test case selection Mechanism
 
  initial 
    $value$plusargs("testcase=%s",counter_cfg::testcase);
  
//Logic to end the simulation

  initial 

    #500 $stop;

endmodule
