module Execute  (  clock, reset, E_Control, IR, npc, W_Control_in, Mem_Control_in, 
                   VSR1, VSR2, enable_execute,  W_Control_out, Mem_Control_out, 
		   NZP, aluout, pcout, sr1, sr2, dr, M_Data, IR_Exec //mem_Bypass_Val
	        ); 	

   input			clock, reset, enable_execute;
   input [1:0] 			W_Control_in;													
   input 			Mem_Control_in;													
   input [5:0] 			E_Control;
   input [15:0] 		IR;
   input [15:0] 		npc;
   input [15:0] 		VSR1, VSR2;

   output [15:0] 		aluout, pcout;
   output [1:0] 		W_Control_out;
   output			Mem_Control_out;
   output [2:0] 		NZP;
   output [2:0] 		sr1, sr2, dr;
   output [15:0] 		M_Data;
   output [15:0]                IR_Exec; 
   
   reg [2:0] 			sr1, sr2, dr;
   reg [1:0] 			W_Control_out;
   reg				Mem_Control_out;
   reg [15:0]                   IR_Exec;
   reg [15:0] 		        M_Data;
   reg [15:0]                   pcout;
   reg [2:0] 			NZP;

   wire [15:0] 			offset11, offset9, offset6, imm5;// trapvect8;
   wire [1:0] 			pcselect1, alu_control;
 //  reg [1:0]                    alu_control_temp;
   wire 			pcselect2, op2select;
   reg [15:0] 			addrin1, addrin2, aluin1_temp, aluin2_temp;
   wire 			alucarry; 		
   wire [15:0] 			VSR1_int, VSR2_int;
   //wire 			alu_or_pc; 
   wire [15:0] 			aluin1, aluin2;

   
   ALU 		alu		(.clock(clock), .reset(reset), .aluin1(aluin1), .aluin2(aluin2), .alu_control(alu_control), .enable_execute(enable_execute), .aluout(aluout), .alucarry(alucarry));

   extension 	ext		(IR, offset11, offset9, offset6, imm5); //trapvect8

assign {alu_control_temp, pcselect1, pcselect2, op2select}  = E_Control;  
      
//assign alu_or_pc        = 1'b1;   
    	
assign VSR1_int         = VSR1;
   
assign VSR2_int         = VSR2;
   
//assign aluin1_temp      = VSR1_int;

assign aluin2 		= (op2select==0) ? imm5: VSR2_int;    

//assign aluin1 		= VSR1;
 
assign aluin1 		= aluin1_temp;

//assign aluin2 		= aluin2_temp;

//assign alu_control      = (alu_or_pc==0) ? alu_control_temp : 2'b00;    

assign alu_control      = alu_control_temp; 





always @ (posedge clock)
     begin
	if(reset) 
        begin
	   NZP <= 3'b001;       
	end
	else if(enable_execute)
             begin
	         if(IR[13:12]== 00) // verified
	         begin
		      if(IR[15:14] == 2'b00) 
                           begin	
		           NZP <= IR[11:9]; 
		           end
		       else if(IR[15:14] == 2'b11)
                            begin 
		            NZP <= 3'b111;
		            end				
		       else 
                            begin
			    NZP <= 3'b000;
		            end
	          end
	          else 
                     begin
	             NZP <= 3'b000; 
	             end	// verified		
	     end
	     else 
                 begin
		 NZP <= 3'b000;
	         end
  end
   
   
//verified the logic throughly
always @(IR, sr1, sr2) 
        begin
       	case(IR[13:12])
	  2'b00: 
	           begin  	      
	       sr1	=	IR[8:6];
	       sr2	=	3'd0; 
	           end	
	  2'b01: 
	           begin 	       
	       sr1	=	IR[8:6];		   
	       sr2	=	IR[2:0];
		   end
	  2'b10: 
	           begin	       
	       sr1	=	IR[8:6];  
	       sr2	=	3'd0;     
	       //sr2      =       IR[2:0];
	       //sr2	=	3'd1;		 
		   end
	  2'b11: 
	           begin 
               sr1	=	IR[8:6];    
	       //sr2      = 	IR[2:0];
	       sr2	=	IR[11:9];      
	           end
          //default: begin
	endcase 
        end
   
// logic for the dr. 
//we know in the alu, load ,branch and jump logic block, dr=IR[11:9] always.  hence dr wont take anyother bits to verify. 
always @(posedge clock) 
       begin
 	    if(reset)
 	        begin
 	        dr <=  3'h0;
 	        end
 	     else if (enable_execute)
 	    begin
	          case(IR[13:12])
		 2'b00: 
		       begin  
		     dr	<=	3'd0;      
		     //dr	<=	IR[11:9];
		       end	
		 2'b01: begin
                          if(IR[15:14]==2'b11)
                          begin
                          dr <= 3'd0;
                          end
                          else
		          begin    
		          dr<=	IR[11:9];
			  end
                        end
		 2'b10: 
		        begin 
                      //dr	<=	IR[11:9];
                      dr	<=	IR[12:10];   
			end
		 /*2'b11: 
		        begin 
		      //dr	<=	3'd0;    
		      dr	<=	IR[11:9];      
		        end*/
                 default: dr <= dr;
	       endcase  		
 	    end
       end

   
   	

always @ (posedge clock)
   	begin
          if(reset)
	  	begin
	     	W_Control_out 	<= 	0;
	     	Mem_Control_out <= 	0;
	     	M_Data		<=	0;
                IR_Exec         <=      0;
	  	end
		
	  else if (enable_execute)
                begin
	     	W_Control_out 	<= 	W_Control_in;
	     	Mem_Control_out <= 	Mem_Control_in;
	       	M_Data		<=	VSR2_int;
                IR_Exec         <=      IR;
	  	end	
         else
                begin
                W_Control_out   <=      W_Control_in;
                Mem_Control_out <=      1;
                M_Data          <=      M_Data;  	
                IR_Exec         <=      IR_Exec;
                end	 
        end
   

always @(VSR1_int)
     begin
     aluin1_temp=VSR1_int;
     end
 
always @(op2select , VSR2_int , imm5)
     begin
  	if(op2select)
       	  aluin2_temp <= VSR2_int;
    	else
 	  aluin2_temp <= imm5;

     end
   
   

always @(pcselect1 , offset11 , offset9 , offset6)
begin
     case(pcselect1)
       0: addrin1	<=	offset11;
       1: addrin1	<=	offset9;
       2: addrin1	<=	offset6;
       3: addrin1	<=	1'b0;
     endcase
end  
   
   	
always @(pcselect2 , npc , VSR1_int , IR)
begin
   	if(pcselect2)
	 	/*begin
	 	if((IR[15:12] == 4'b0000) || (IR[15:12] == 4'b1100) ) 
                        begin
			addrin2 <= npc-1;
		        end
		else */
                        begin 
       		        addrin2 <= npc;
		      end
   	else
		addrin2 <= VSR1_int;
end

   
     
always @(posedge clock)
        if (reset)
                begin
                pcout <= 0;
                end
        else if (enable_execute)
                begin
                pcout <= addrin1 + addrin2;
                end
        else
                pcout <= pcout; 


endmodule