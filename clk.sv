module clk;
bit clk;
always 
#5 clk=~clk;
endmodule
/* always
   #5 clk++;
endmodule*/