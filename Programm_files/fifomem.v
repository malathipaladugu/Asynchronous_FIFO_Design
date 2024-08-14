module fifomem #(parameter DSIZE = 8 ,
                 parameter ASIZE = 4 )
( input[ASIZE-1:0] raddr,waddr,
  input wclk,wen,wfull,
  input[DSIZE-1:0] wdata,
  output[DSIZE-1:0] rdata  
);	

localparam DEPTH = 1<<ASIZE;

reg[DSIZE-1:0] mem [0:DEPTH-1];

assign rdata = mem[raddr];  // read is asynchronous

always @(posedge wclk)
begin
	if(wen && !wfull) mem[waddr] <= wdata;
end

endmodule 		