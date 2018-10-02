module demo;
int a[10]= '{10,2,3,4,5,100,50,40,33,99};
initial
begin
foreach(a[i])
$display("%d%d",i,a[i]);
end
endmodule