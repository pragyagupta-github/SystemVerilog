module MemAccess      ( mem_state, M_Control, M_Data, M_Addr, memout, 
                        Data_addr, Data_din, Data_dout, Data_rd      );


   input  [1:0] 	mem_state;
   input 		M_Control;
   input [15:0] 	M_Data;
   input [15:0] 	M_Addr;
   input [15:0] 	Data_dout;

   output [15:0] 	Data_addr;
   output [15:0] 	Data_din;
   output 		Data_rd;
   output [15:0] 	memout;

   //reg [15:0] 		addr;           
   //reg [15:0] 		din;            
   //reg 			rd;                  

   reg [15:0] 		Data_addr;
   reg [15:0] 		Data_din;
   reg 			Data_rd;


   
   	
always @(mem_state , M_Addr ,M_Data , Data_dout , M_Control, Data_din, Data_rd)
    begin
    	if(mem_state==0)  				        
      	       begin
       		         Data_din	<=	16'h0;      		
          	         Data_rd	<=	1'b1;   // reading from the load 
                         begin
                            if(M_Control==0)
	  	            Data_addr	<=	M_Addr;  		
       	 	            else 
                            begin
	  	            Data_addr	<=	Data_dout;
	    	            //Data_din	<=	16'h0;      		
          	            //Data_rd	<=	1'b1;   
                            end  
                         end 
   		end 


    	else if(mem_state==1) 		
     	        begin
	     	         Data_addr	<=	M_Addr;    		
	     	         Data_din	<=	16'h0;      		
         	         Data_rd	<=	1'b1;  // reading from indirect addr
     	        end


    	else if(mem_state==2)    
		begin
                        Data_din	<=	M_Data;
        	        Data_rd		<=	1'b0;  // writing to store 
                        begin
      		             if(M_Control==0)
	  	    	     Data_addr	<=	M_Addr;  		
       		             else 
                             begin
	  	    	     Data_addr	<=	Data_dout;    		
		  	    // Data_din	<=	M_Data;
        	             //Data_rd	<=	1'b0;
                             end
                        end         		
      	        end


    	else                  		
      	        begin
			Data_addr	<=	16'hz;     		
		        Data_din	<=	16'hz;
		        Data_rd		<=	1'bz; 
		end
  end
	
assign memout = Data_dout;

   
endmodule