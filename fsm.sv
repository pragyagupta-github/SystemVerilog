module fsm(
input clk, rst, x,
output reg y);
enum{s0=0,s1=0,s2=1,s3=1}state_reg, state_next;
// sequential
always@(posedge clk)
 begin
   if(!rst)
    state_reg<=s0;
   else
    state_reg<=state_next;
 end
// combination logic
always@(state_reg,x)
begin
   case(state_reg)
s0: if(x) 
    begin
      state_next=s1;
      y=1'b0;
    end
    else
     begin
       state_next=s0;
       y=1'b0;
     end
 s1: if(x)
     begin
      state_next= s1;
      y=1'b0;
     end
     else
     begin
      state_next= s2;
      y=1'b0;
    end
s2: if(x)
     begin
       state_next=s3;
       y=1'b0;
     end
     else
     begin
       state_next= s2;
       y=1'b0;
     end
s3: if(x)
     begin
       state_next=s0;
       y=1'b1;
     end
     else
     begin
       state_next= s2;
       y=1'b0;
     end
endcase
end
endmodule