module counter_ref(
 input  logic  clk,rst,updown,load,
 input  logic [3:0] d,
 output logic [3:0] count
);

always_ff@(posedge clk,posedge rst)
begin
if(rst)
count<= 0;
else if (load)
count<=d;
else if(count == 4'b1001)
count <= 4'b0000;
else
begin
if(updown)
count<=count+1;
else
count<=count -1;
end
end
endmodule
