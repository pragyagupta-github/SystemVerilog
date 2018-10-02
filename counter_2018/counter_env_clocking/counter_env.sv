class counter_env;

 counter_gen gen;
 counter_drv drv;
 counter_mon mon;
 counter_cov cov;
  
 function new();
  gen = new();
  drv = new();
  mon = new();
  cov = new();
 endfunction
 
 task run();
  fork
    gen.run();
    drv.run();
    mon.run();
    cov.run();
  join
 endtask

endclass
