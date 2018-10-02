interface counter_if(input bit clk,rst);
 bit updown;
 bit load;
 bit [3:0] d;
 bit [3:0] count;

modport MON(input clk,rst,updown,load,d,count); 
modport DUT(input clk,rst,updown,load,d, output count); 

/////////////////////clocking block////////////////////////////
clocking cb @(posedge clk);
	default input #1 output #0;
//default output #1;	
	input  count;
	output updown;
	output load;
	output d;
endclocking
		
//////////////////////endclocking//////////////////////////////

////////////////////declare modport////////////////////////////
modport BFM(clocking cb,output rst);
	
endinterface
