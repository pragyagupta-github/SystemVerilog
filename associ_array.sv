module associ_array;
int a[*];
initial
begin
a[200]=700;
a[800]=1000;
a[1000]=300;
$display("%d",a.num);
$display("%p",a);
a.delete(800);
$display("%p",a);
a.delete();
$display("%p",a);
end
endmodule