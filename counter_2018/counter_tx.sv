class counter_tx;
 rand bit updown;
 rand bit load;
 rand bit [3:0] d;
      bit [3:0] count;

 function void copy(output counter_tx tx);
  tx = new();
  tx.updown = updown;
  tx.load = load;
  tx.d = d;
  tx.count = count;
 endfunction

 function void print();
  $display("updown=%d",updown);
  $display("load=%d",load);
  $display("d=%d",d);
  $display("count = %d",count);
 endfunction

//Compare function
// flag =1 Compare fail
// flag =0 Compare pass
 function bit compare(input counter_tx tx);
  bit flag;
  if((tx.updown != updown) || (tx.load != load) || (tx.d != d) || (tx.count != count) )
    begin
       flag = 1;
    end
  return flag;
 endfunction
endclass
