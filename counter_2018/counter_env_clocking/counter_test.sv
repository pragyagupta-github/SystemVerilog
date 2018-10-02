program tb_top;

 counter_env env;

 initial begin
  env = new();
  env.run();
  $display("I am in Test block");
 end

endprogram
