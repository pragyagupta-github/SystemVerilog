module pckd;
reg [7:0]a= 8'b1010_1111;
reg b[7:0];
initial
begin
for(int i=0;i<8;i++)
begin
b[i]=a[i];
$display("%p",b);
end
/*assign b[7]=a[7],
       b[6]=a[6],
       b[5]=a[5],
       b[4]=a[4],
       b[3]=a[3],
       b[2]=a[2],
       b[1]=a[1],
       b[0]=a[0];
initial 
begin
$display("%p",b);*/
end
endmodule