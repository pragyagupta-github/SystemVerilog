program fetch_test(fetch_intf i, fetch_intf j);
fetch_environment en;
initial
begin
en=new(i,j);
en.build;
repeat(500)
begin
#10 en.run();
end
end
endprogram