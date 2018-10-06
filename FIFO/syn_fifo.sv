module syn_fifo(data_out,full,empty,data_in,clk,rst,wr_en,rd_en);
   parameter data_width    = 4;
   parameter address_width = 4;
   parameter ram_depth     =16;


   output [data_width-1:0] data_out;
   output            full;
   output            empty;
   input [data_width-1:0]  data_in;
   input            clk;
   input            rst;
   input            wr_en;
   input            rd_en;


   reg [address_width-1:0]    wr_pointer;
   reg [address_width-1:0]    rd_pointer;
   reg [address_width :0]     status_count;
   reg [data_width-1:0]       data_out ;
   wire [data_width-1:0]      data_ram ;


   

   always @ (posedge clk,posedge rst)
     begin
    if(rst)
      wr_pointer = 0;
    else
      if(wr_en)
        wr_pointer = wr_pointer+1;
     end

   always @ (posedge clk,posedge rst)
     begin
    if(rst)
      rd_pointer = 0;
    else
      if(rd_en)
        rd_pointer = rd_pointer+1;
     end

   always @ (posedge clk,posedge rst)
     begin
    if(rst)
      data_out=0;
    else
      if(rd_en)
        data_out=data_ram;
     end

   always @ (posedge clk,posedge rst)
     begin
    if(rst)
      status_count = 0;
    else
      if(wr_en && !rd_en && (status_count != ram_depth))
        status_count = status_count + 1;
      else
        if(rd_en && !wr_en && (status_count != 0))
          status_count = status_count - 1;
     end // always @ (posedge clk,posedge rst_a)


   assign full = (status_count == (ram_depth-1));
   assign empty = (status_count == 0);
   
   memory_16x4 #(data_width,address_width,ram_depth) u1 (.address_1(wr_pointer),.address_2(rd_pointer),.data_1(data_in),.data_2(data_ram),.wr_en1(wr_en),.rd_en2(rd_en),.clk(clk));


endmodule 

