module counter(counter_if.DUT inf);

always@(posedge inf.clk,posedge inf.rst)
begin
if(inf.rst)
inf.count<= 0;
else if (inf.load)
inf.count<= inf.d;
else
begin
if(inf.updown)
inf.count<= inf.count+1;
else
inf.count<= inf.count -1;
end
end
endmodule
