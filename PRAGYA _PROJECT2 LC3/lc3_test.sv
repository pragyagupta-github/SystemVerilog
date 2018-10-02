program lc3_test(lc3_intf l, fetch_intf fi);
lc3_environment en;
initial
begin
en=new(l,fi);
en.build;
repeat(1000)
begin
#10 en.run();
end
end
endprogram