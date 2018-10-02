module decode( clock, reset, enable_decode, dout, E_Control,npc_in, Mem_Control, W_Control, IR, npc_out);

input clock, reset, enable_decode;
input [15:0] dout;
input [15:0] npc_in;
output reg [1:0] W_Control;
output Mem_Control;
output [5:0] E_Control;
output [15:0] IR;
output [15:0] npc_out;



reg [15:0] IR, npc_out;
reg M_Control;

//reg [1:0] inst_type;  reg pc_store; UNNECESSARILY DECLARATION OF REG 


reg [1:0] pcselect1, alu_control;
reg pcselect2, op2select;
wire [3:0] opcode;


assign opcode = dout[15:12];// THIS STATEMENT SHOWS THAT IR=DOUT; DOUT[15:12]=OPCODE[3:0]
assign Mem_Control = M_Control;
assign E_Control = {alu_control, pcselect1, pcselect2, op2select};

// always block for IR and npc output
// AS MENTIONED IN THE SPEC. WHEN RESET IS ACTIVE HIGH ALL THE OUTPUT GOES TO ZERO HENCE RESET==0
//WHEN ENABLE_DECODE ==1 ONLY THEN WE GET THE DEFINED OUTPUTS
always @(posedge clock)
begin
	if(reset)
	begin
		IR <= 16'd0;
		npc_out <= 16'd0;
	end
	else if (enable_decode)
	begin
		IR <= dout;
		npc_out <= npc_in;
		//npc_out <= npc_in + 1; ILLEGAL OUTPUT 
	end
        else
          begin
           IR<=IR;
           npc_out<=npc_out;
          end
end

// ALWAYS BLOCK NOT REQUIRED BECAUSE THE INST_TYPE ISN'T AN OUTPUT FOR THE DECODE BLOCK
/*always @(posedge clock)
begin
if(reset)
inst_type <= 2'd0;
else if (enable_decode)
begin
case (opcode[1:0])
2'b00: inst_type <= 2'd1;
2'b01: inst_type <= 2'd0;
2'b10: inst_type <= 2'd1;
2'b11: inst_type <= 2'd2;
endcase
end
end*/

//E_CONTROL LOGIC 


always @(posedge clock)// alu logic block 
begin
	if(reset)
	begin
		alu_control <= 2'd0; // WHEN RESET ==1; E_CONTROL GOES TO ZERO
		op2select <= 1'd0;   
		pcselect1 <= 2'd0;
		pcselect2 <= 1'd0;
	end
	else if (enable_decode)
	begin
		case(opcode[1:0])
		
		2'b00: // block for BR and JMP 
		begin
			alu_control <= 2'd0;
			op2select <= 1'b0;
			case (opcode[3:2])
				2'b00:
				begin
					pcselect1 <= 2'd1;
					pcselect2 <= 1'b1;
				end
				2'b11:
				begin
					pcselect1 <= 2'd3;
					pcselect2 <= 1'b0;
				end
				default:
				begin
					pcselect1 <= 2'd0;
					pcselect2 <= 1'b0;
				end
			endcase // satisfied block for BR and JMP
		end
		2'b01:
		begin //BLOCK FOR ADD , AND , NOT
			pcselect1 <= 2'd0;
			pcselect2 <= 1'b0;
			op2select <= ~dout[5];  
                        //WHEN DOUT[5] IS 1, OP2SELECT GOES TO 0 AND VICE VERSA. 
                        // HENCE WE NEED ~DOUT TO ASSIGN THE OUTPUT OF OP2SELECT
			case (opcode[3:2])
				2'b00: alu_control <= 2'd0;
				2'b01: alu_control <= 2'd1;
				2'b10: alu_control <= 2'd2;   
				default: alu_control<= 2'd0;
			endcase //END OF BLOCK FOR ADD, AND ,NOT
		end
		2'b10:
		begin  //BLOCK FOR LD , LDR, LDI, LEA
			alu_control<= 2'd0;
			op2select<=1'b0;
			if (opcode[3:2]==2'b01)
			begin
				pcselect1 <=2'd2;// 0 0 1 0 0 0 - LDR
				pcselect2 <=1'd0;
			end
			else
			begin // OUTPUT FOR LD, LDI, LEA IS SAME 
				pcselect1 <= 2'd1;   
				pcselect2 <= 1'b1;
			end
			
		end // END OF BLOCK FOR LD, LDR, LDI , LEA
		2'b11:
		begin // ST, STR, STI
			alu_control<=2'd0;
			op2select <= 1'b0;
			if (opcode[3:2]==2'b01)
			begin
				pcselect1 <=2'd2;
				pcselect2 <=1'b0;
			end
			else
			begin
				pcselect1 <= 2'd1;
				pcselect2 <= 1'b1;
			end
			
		end // END OF ST, STR, STI
		endcase
	end 
        else
             begin
                alu_control <= alu_control; // WHEN RESET ==1; E_CONTROL GOES TO ZERO
		op2select <= op2select;   
		pcselect1 <= pcselect1;
		pcselect2 <= pcselect2;
             end
end// alu logic block


// W_CONTROL LOGIC

always @(posedge clock)
begin
	if(reset)
	begin
		W_Control <= 2'd0;
	end
	else if (enable_decode)
	begin
		case(opcode[1:0])
		2'b00:
		begin
			W_Control <= 2'd0;
		end
		2'b01:
		begin
			W_Control <= 2'd0;
		end
		2'b10:
		begin
			if (opcode[3:2]==2'b11)
			begin
				W_Control<=2'd2;
			end
			else
				W_Control<=2'd1;
		end
		2'b11:
		begin
			W_Control<=2'd0;
		end
		endcase
	end 
      else
      W_Control <=W_Control;
end 

//M_CONTROL LOGIC 

always @(posedge clock)
begin
	if (reset)
	begin
		M_Control <= 1'b0;
	end
	else if (enable_decode)
	begin
		case(opcode[1:0])
		2'b10:
		begin
			M_Control <= (opcode[3:2]==2'b10) ? 1'b1: 1'b0;
		end
		2'b11:
		begin
			M_Control <= (opcode[3:2]==2'b10) ? 1'b1: 1'b0;
		end
                 default: begin
                        M_Control <= M_Control;
                          end
		endcase
	end
       else
       M_Control<=M_Control;
end


endmodule