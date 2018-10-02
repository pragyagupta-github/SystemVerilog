class counter_env;

 counter_gen gen;
 counter_drv drv;
 counter_mon mon;
 counter_cov cov;
 counter_scb scb;
  
 function new();
  gen = new();
  drv = new();
  mon = new();
  cov = new();
  scb = new();
 endfunction
 
 task run();
  fork
    gen.run();
    drv.run();
    //#1;
    mon.run();
    cov.run();
    scb.run();
  join
 endtask

endclass
