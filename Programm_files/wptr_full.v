module wptr_full #(parameter ASIZE= 4)
(
  input wclk,wrst_n,wen,
  input[ASIZE:0] w_rptr,
  output[ASIZE-1 :0] waddr,
  output reg [ASIZE :0] wptr,
  output reg wfull

);
 
 reg [ASIZE:0] wbin;
 wire [ASIZE:0] wbinnext, wgraynext;
 
 wire wfull_val;
 
 always @(posedge wclk or negedge wrst_n)
 begin
	if(~wrst_n) begin
	   wbin <=0;
	   wptr <=0; end 
	else begin
      wbin <= wbinnext;
	   wptr <= wgraynext; end 
 end  
 
 assign wbinnext = wbin + (~wfull & wen);
 assign wgraynext = (wbinnext>>1) ^ wbinnext; 
 
 assign waddr = wbin[ASIZE-1:0];
 
 //---------------------------------------------------------------
 // FIFO full when the next wptr == synchronized rptr or on reset
 //---------------------------------------------------------------
 
 assign wfull_val = (wgraynext == {~w_rptr[ASIZE: ASIZE-1],w_rptr[ASIZE-2:0]});
 
 always @(posedge wclk or negedge wrst_n)
 begin
	 if (!wrst_n) wfull <= 1'b0;  // when reset fifo is empty
	 else wfull <= wfull_val;
 end 

endmodule 