module w2r_sync #(parameter ASIZE = 4)
(
  input rclk,rrst_n,
  input[ASIZE:0] wptr,
  output reg[ASIZE:0] r_wptr
);

reg[ASIZE:0] r_wptr1;

always @(posedge rclk or negedge rrst_n)
begin
	if(~rrst_n)
	 { r_wptr,r_wptr1} <= 0;
	else 
	 { r_wptr,r_wptr1} <= {r_wptr1,wptr};
	end 
endmodule