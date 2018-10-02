module extension(IR, offset11, offset9, offset6, imm5); //trapvect8,

input 	[15:0] 	IR;
output       [15:0] 	offset11, offset9, offset6, imm5;//trapvect8,


   assign 		offset11  ={{5{IR[10]}}, IR[10:0]};
   
   assign 		offset9   ={{7{IR[8]}}, IR[8:0]};  
  
   assign 		offset6	  ={{10{IR[5]}}, IR[5:0]};   
   
   assign 		imm5	  ={{11{IR[4]}}, IR[4:0]}; 

endmodule