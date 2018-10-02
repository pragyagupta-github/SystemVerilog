module dynamic_array;
int a[];
initial
begin
$display("%d",a.size);
a=new[10];
a[2]=23;
a[7]=30;
a[9]=78;
$display("%d",a[7]);
$display("%d",a[3]);
$display("%p",a);
a.delete(7);
$display("%d",a[7]);
end
endmodule
