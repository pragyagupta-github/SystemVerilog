module memory_16x4(data_1,data_2,wr_en1,rd_en2,clk,address_1,address_2);

   parameter data_width    = 4;
   parameter address_width = 4;
   parameter ram_depth     =16;

   
   input     [data_width-1:0]      data_1;
   output     [data_width-1:0]      data_2;
   input     [address_width-1:0]   address_1;
   input     [address_width-1:0]   address_2;
   input                           wr_en1,clk,rd_en2;

   
   reg [address_width-1:0]     memory[0:ram_depth-1];
   reg [data_width-1:0]        data_2_out;
   wire [data_width-1:0]  data_2;
   

   always @(posedge clk)
     begin
    if (wr_en1)
      memory[address_1]=data_1;
     end

   always @(posedge clk)
     begin
    if (rd_en2)
      data_2_out=memory[address_2];
     end

   assign data_2=(rd_en2)?data_2_out:8'b0;

endmodule // memory_16x4
