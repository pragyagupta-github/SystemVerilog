module Controller_Pipeline     (	
				clock, reset, IR, complete_instr, complete_data, psr, NZP, 
				enable_fetch, enable_decode, enable_execute, enable_writeback, 
				br_taken,enable_updatePC, mem_state						
				);

	input			clock, reset, complete_instr, complete_data;	
	input [15:0] 		IR;//IR_Exec;
	input [2:0] 		psr, NZP;

	output			enable_fetch, enable_decode, enable_execute, enable_writeback, enable_updatePC;
	output [1:0] 		mem_state;
	output 			br_taken;
   
	reg [4:0] 		enables;
        reg [4:0] 		prev_enables;
	reg [4:0] 		state, next_state;
	reg[1:0]		mem_state;
	reg			br_taken;

	wire [15:0] 		IR_Exec;
	reg [1:0] 		mem_ctrl_Cstate, mem_ctrl_Nstate;
	wire 			deassert_enable_writeback;
	

assign	IR_Exec = IR;
	
assign  {enable_updatePC, enable_fetch, enable_decode, enable_execute, enable_writeback} = enables;	
	
always @ (posedge clock)
    begin
		if(reset)
	  	begin
	     	state	<=	0;
	  	end
		else 
		begin			
	     	state 	<=	next_state;
		end	
	end
	

always @ (state, enables, next_state, complete_instr) 
       begin
		case(state) 
		5'b0: 	                begin// update pc state 1
					enables <= 5'b10000;
					next_state <= 5'd1;
				        end 


		5'd1:                   begin      
			                if(complete_instr) 
					begin
				        enables <= 5'b10100;
					next_state <= 5'd2;
					end
					else begin
					enables <= 5'b01000;
					next_state <= 5'd1;
					end
			                end


		5'd2: 	                begin
					//enables <= 5'b00010;
					enables <= 5'b11110;
					next_state <= 5'd3;
				        end

		5'd3: 	                begin
					enables <= 5'b00010;
					//enables <= 5'b00101;
					next_state <= 5'd4;
				        end

		5'd4: 	                begin
					//enables <= 5'b00001;
		                        enables <= 5'b10001;
		                        next_state <= 5'd5;
				        end

		5'd5: 	                begin
					enables <= 5'b10000;
					next_state <= 5'd1;
				        end

		default:              
                                        begin
					enables <= 5'b00000;
					next_state <= 5'd1;
				        end
		endcase
	end

	

always @ (br_taken, psr, NZP, state) 
        begin
	if(|(psr & NZP))
                begin
                   if((state == 5'd3)) 
                   begin 
       		   br_taken <= 1;
		   end
                end
        else 
                   begin
		   br_taken <= 0;
		   end
        end

   	

always @ (posedge clock)
   	begin
		if(reset)
                begin
	   	mem_ctrl_Cstate <= 2'd0;
		end
		else 
                begin
	   	mem_ctrl_Cstate <= mem_ctrl_Nstate;
		end
  	end
   
   	
always @ (mem_ctrl_Cstate , IR_Exec , complete_data , mem_ctrl_Nstate, mem_state)
  begin
	case(mem_ctrl_Cstate) 
	  	2'd3: 
                begin 
	     	if(  ((IR_Exec[13:12] == 2'b11) || (IR_Exec[13:12] == 2'b10)) && (IR_Exec[15:14] != 2'b11) ) 	
	       	begin
		                if(IR_Exec[15:14] == 2'b10) 
                                begin  
			     	mem_ctrl_Nstate = 1;
			     	mem_state = 1;
			  	end
			  	else 
                                begin
			     	                if(IR_Exec[13:12] == 2'b11) 
                                                begin  
					        mem_ctrl_Nstate = 2;
						mem_state = 2;
			   		        end
			  		        else if (IR_Exec[13:12] == 2'b10) 
                                                begin 
						mem_ctrl_Nstate = 0;
						mem_state = 0;
			   		        end
					        else 
                                                begin
						mem_ctrl_Nstate = 3;
				   		mem_state = 3;
						$display("INVALID STATE");
					        end
				end						
	    	end		
	     	else 
                begin 
		        if (! ((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001) || (IR_Exec[15:12] == 4'b1110)))
                        begin
                        mem_ctrl_Nstate = 3;
		        mem_state = 3; 
                        end	     
	  	end 
end
	  	2'd1: 
                begin 
	   		if(complete_data)
                        begin
		   		if((IR_Exec[13:12] == 2'b11)) 
                                begin 
		      		mem_ctrl_Nstate = 2; 
		      		mem_state = 2;
		   		end
		   		else if((IR_Exec[13:12] == 2'b10)) 
                                begin
		      		mem_ctrl_Nstate = 0; 
		      		mem_state = 0;
		   		end
				else 
                                begin
			   	mem_ctrl_Nstate = 3; 
			   	mem_state = 3;
				end
			end
			else 
                        begin
		   	mem_ctrl_Nstate = 1; 
		   	mem_state = 1;
			end	
		end
		2'd2: begin 
			if(complete_data) 
                        begin
		      	mem_ctrl_Nstate = 3;
		      	mem_state = 3;
		   	end
		   	else begin
		      	mem_ctrl_Nstate = 2;
		      	mem_state = 2;
		   	end
		end
		
		2'd0: begin
			if(complete_data) 
                        begin
			mem_ctrl_Nstate = 3;
			mem_state = 3;
		  	end
		  	else begin
			mem_ctrl_Nstate = 0;
			mem_state = 0;
		  	end
		     end	
		default: 
                begin
		  	mem_ctrl_Nstate = 3;
		  	mem_state = 3;
		end	  
		endcase
	end
	

assign 	stall_pipe = (  ((mem_ctrl_Cstate == 2'd0) && (complete_data == 0))   || ((mem_ctrl_Cstate == 2'd2) && (complete_data == 0)) ||
		        ( ((IR_Exec[13:12] == 2'b11) || (IR_Exec[13:12] == 2'b10))  && (IR_Exec[15:14] == 2'b11)  && ((mem_ctrl_Cstate == 2'd3) ||(mem_ctrl_Cstate == 2'd1)))) ? 1'b1 : 1'b0;
   
	

assign	deassert_enable_writeback = (complete_data && (mem_ctrl_Cstate == 2'd2))?1:0;
 

endmodule