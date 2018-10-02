module odd;
int i=0;
initial 
begin
repeat(20)
begin
#5 i=$urandom_range(0,100);
if(i%2!=0)
continue;
else
$display("%d",i);
end
end
endmodule