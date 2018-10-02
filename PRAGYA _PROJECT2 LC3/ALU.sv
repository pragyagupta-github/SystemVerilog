module ALU(clock, reset, aluin1, aluin2, alu_control, enable_execute, aluout, alucarry);
   
   input			clock, reset;
   input [15:0] 		aluin1, aluin2;
   input [1:0] 			alu_control;
   input			enable_execute;

   output [15:0] 		aluout;
   output 			alucarry;
   
   reg [15:0] 			aluout;
   reg 				alucarry;


   always @(posedge clock)
     if (reset)
       begin
  	  alucarry 	<= 0;
  	  aluout		<= 0;
       end
     else if (enable_execute)
       begin
  	  case(alu_control)
    	    0: {alucarry,aluout}	<=  aluin1+ aluin2;
			
    	    1: {alucarry,aluout}	<= {1'b0, aluin1&aluin2};
			
    	    //1: {alucarry,aluout}	<= {1'b0 , {aluin1 & {aluin2[15:7],aluin2[5], aluin2[6], aluin2[4:0]}}};
			
    	    2: {alucarry,aluout}	<= {1'b0, ~aluin1};

    	    default: {alucarry,aluout}	<= {16{1'b0}};

	   //{alucarry,aluout}	<= ~(aluin1^aluin2);  
   	  endcase
       end	

endmodule