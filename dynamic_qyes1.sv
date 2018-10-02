module dynamic_qyes1;
int a[];
int b[];
initial
begin
a=new[30];
b=new[60];
//b=new[60](a);
for (int i=0; i<30; i++)
begin
a[i]=$urandom_range(0,100);
//for (int j=0; j<60; j++)
//begin
b[i]=a[i];
//end
$display("%p",a);
$display("%p",b);
end
end
endmodule