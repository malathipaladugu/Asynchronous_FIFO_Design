`timescale 1ns / 1ps

module tb_async_fifo();
    
    // Inputs
    reg wclk;
    reg rclk;
    reg rrst_n,wrst_n;
    reg wr_en;
    reg rd_en;
    reg [7:0] wdata;
    
    // Outputs
    wire [7:0] rdata;
    wire full;
    wire empty;
    
    // Instantiate the FIFO module
    asyncfifo #(8,3) uut (
        .wclk(wclk),
        .rclk(rclk),
        .rrst_n(rrst_n), .wrst_n(wrst_n),
        .winc(wr_en),
        .rinc(rd_en),
        .wdata(wdata),
        .rdata(rdata),
        .wfull(full),
        .rempty(empty)
    );
    
    // Clock generation
    initial begin
        wclk = 0;
        forever #10 wclk = ~wclk; // 100 MHz write clock
    end
    
    initial begin
        rclk = 0;
        forever #5 rclk = ~rclk; // ~71 MHz read clock
    end
    
    // Test stimulus
    initial begin
        rrst_n = 0; wrst_n=0;
        wr_en = 0;
        rd_en = 0;
        wdata = 0;
        #20;
        
        rrst_n = 1; wrst_n=1;
        
        // Write data into the FIFO
        @(posedge wclk);
        wr_en = 1;
        wdata = 8'hA5;
        @(posedge wclk); 
        wdata = 8'h5A;
        @(posedge wclk);
        wdata = 8'hFF;
        @(posedge wclk);
        wr_en = 0;

        // Wait for a few clock cycles
        #40;
        
        // Read data from the FIFO
        @(posedge rclk);
        rd_en = 1;
        @(posedge rclk);
        @(posedge rclk);
        @(posedge rclk);
        rd_en = 0;
        
		  #10
		   @(posedge wclk);
        wr_en = 1;
        wdata = 8'hA5;
        @(posedge wclk); 
        wdata = 8'h5A;
        @(posedge wclk);
        wdata = 8'hFF;
        @(posedge wclk);
		  wdata = 8'hA5;
        @(posedge wclk); 
        wdata = 8'h5A;
        @(posedge wclk);
        wdata = 8'hFF;
        @(posedge wclk);
		  wdata = 8'hA5;
        @(posedge wclk); 
        wdata = 8'h5A;
        @(posedge wclk);
        wdata = 8'hFF;
        @(posedge wclk);
     
        $stop; // End of simulation
    end
    
endmodule
