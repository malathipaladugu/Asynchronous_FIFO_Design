module rptr_empty #(parameter ASIZE= 4)
(
  input rclk,rrst_n,ren,
  input[ASIZE:0] r_wptr,
  output[ASIZE-1 :0] raddr,
  output reg [ASIZE :0] rptr,
  output reg rempty

);
 
 reg [ASIZE:0] rbin;
 wire [ASIZE:0] rbinnext, rgraynext;
 
 wire rempty_val;
 
 always @(posedge rclk or negedge rrst_n)
 begin
	if(~rrst_n)
	   
		{rbin,rptr} <=0;
	else begin
      rbin <= rbinnext;
	   rptr <= rgraynext; end 	
 end  
 
 assign rbinnext = rbin + (~rempty & ren);
 assign rgraynext = rbinnext>>1 ^ rbinnext; 
 
 assign raddr = rbin[ASIZE-1:0];
 
 //---------------------------------------------------------------
 // FIFO empty when the next rptr == synchronized wptr or on reset
 //---------------------------------------------------------------
 
 assign rempty_val = (rgraynext == r_wptr);
 
 always @(posedge rclk or negedge rrst_n)
 begin
	 if (!rrst_n) rempty <= 1'b1;  // when reset fifo is empty
	 else rempty <= rempty_val;
 end 

endmodule 