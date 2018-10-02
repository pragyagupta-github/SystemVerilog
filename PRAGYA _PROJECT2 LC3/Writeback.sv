module Writeback               (        clock, reset, enable_writeback, 
                                        W_Control, aluout, memout, pcout,// npc, 
					sr1, sr2, dr, d1, d2, psr 
				);

  	input 		clock, reset, enable_writeback;
  	input 	[15:0] 	aluout, memout, pcout;// npc;
  	input 	[1:0] 	W_Control;
  	input 	[2:0] 	sr1, sr2, dr;     	
  	
  	output	reg [2:0]	psr;
  	output 	reg [15:0] 	d1, d2;				

  	reg 	[15:0] 	DR_in;      	
	//reg	[2:0]	psr;

  	
reg_file RF 	(.clock(clock), .sr1(sr1), .sr2(sr2), .din(DR_in), .dr(dr), .wr(enable_writeback),.d1(d1), .d2(d2) );
  	

   	

always @(W_Control or aluout or memout or pcout or DR_in)
  	begin
		case(W_Control)
	  		
        		0:         DR_in = aluout;
                        1:         DR_in = memout;
	  		2:         DR_in = pcout;
			//default :  DR_in = DR_in;
        		//2: DR_in<=aluout;     // wrong assignments
	  		//0: DR_in<=aluout;
		
          		//3: DR_in<=npc;            // npc is not defined in specs
               endcase      	
  	end
 	
  	
always @(posedge clock)
  	begin
         	if (reset)
        	begin
       		psr <= 3'b000;
        	end
                 	if (enable_writeback) 
                	begin
	                 	if(DR_in[15])    
				psr[2]  <=      1'b1;
				//psr	<=	3'h6; 
			        else  if(^(DR_in) == 0)
	        	        psr[1]<=	1'b1;
				 else if(!DR_in[15]) 
			        psr[0]	<=	1'b1;
                                else
                                psr     <=      psr;
	 	        end
              //  psr <= psr;       	
    end    	

endmodule

