module tb_arbiter;
reg clock,reset,ack;
reg [3:0] req;
wire [3:0] grant;

arbiter DUT (.*);

initial
clock=1'b0;

always
#5 clock=~clock;

initial
begin
	reset=1'b0;
    #10 reset=1'b1;
    #40 reset=1'b0;
    #10 reset=1'b1;
end

initial
begin
	ack=1'b0;
	#30;
	for(int i=0;i<70;i++)
	begin
		ack=~ack;
		#30;
	end
end

initial
begin
	for(int i=0;i<50;i++)
	begin
		req=$urandom_range(0,15);
		#40;
	end
end

initial
  #2500	$stop;

initial
$monitor($time," clock=%0d reset=%0d ack=%0d req=%0d grant=%0d",clock,reset,ack,req,grant);
endmodule