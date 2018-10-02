module counter(
input bit clk,rst,updown,load,
input [3:0] d,
output bit [3:0] count
);

always@(posedge clk,posedge rst)
begin
if(rst)
count<= 0;
else if (load)
count<=d;
else
begin
if(updown)
count<=count+1;
else
count<=count -1;
end
end
endmodule
