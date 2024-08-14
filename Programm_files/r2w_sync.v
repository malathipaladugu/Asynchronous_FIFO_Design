module r2w_sync #(parameter ASIZE = 4)
(
  input wclk,wrst_n,
  input[ASIZE:0] rptr,
  output reg[ASIZE:0] w_rptr
);

reg[ASIZE:0] w_rptr1;

always @(posedge wclk or negedge wrst_n)
begin
	if(~wrst_n)
	 { w_rptr,w_rptr1} <= 0;
	else 
	 { w_rptr,w_rptr1} <= {w_rptr1,rptr};
	end 
endmodule 