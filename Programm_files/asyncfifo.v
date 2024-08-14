module asyncfifo #(parameter DSIZE = 8 ,
                   parameter ASIZE = 4 )
( input wclk,winc,wrst_n,
  input rclk,rinc,rrst_n,
  input [DSIZE-1:0] wdata,
  output [DSIZE-1:0] rdata,
  output rempty,wfull
);

wire [ASIZE-1:0] waddr,raddr;
wire [ASIZE:0] rptr,w_rptr,wptr,r_wptr;


fifomem #(DSIZE, ASIZE) dut1 (  .raddr(raddr), .waddr(waddr),
										  .wclk(wclk), .wen(winc), .wfull(wfull),
										  .wdata(wdata), .rdata(rdata)  
										);	
				

r2w_sync  #(ASIZE) dut2 ( .wclk(wclk), .wrst_n(wrst_n),
								  .rptr(rptr), .w_rptr(w_rptr)
								);


w2r_sync  #(ASIZE) dut3 ( .rclk(rclk), .rrst_n(rrst_n),
								  .wptr(wptr), .r_wptr(r_wptr)
								);
								
rptr_empty  #(ASIZE) dut4 (
							  .rclk(rclk), .rrst_n(rrst_n), .ren(rinc),
							  .rptr(rptr), .r_wptr(r_wptr),
							  .raddr(raddr), .rempty(rempty)

							);

wptr_full  #(ASIZE) dut5 (
							  .wclk(wclk), .wrst_n(wrst_n), .wen(winc),
							  .wptr(wptr), .w_rptr(w_rptr),
							  .waddr(waddr), .wfull(wfull)

							);
								

endmodule 
