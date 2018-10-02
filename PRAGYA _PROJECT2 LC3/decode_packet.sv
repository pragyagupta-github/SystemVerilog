class decode_packet;

logic clock, reset, enable_decode;
logic [15:0] dout;
logic [15:0] npc_in;

logic [1:0] W_Control;
logic Mem_Control;
logic [5:0] E_Control;
logic [15:0] IR;
logic [15:0] npc_out;
endclass