# Asynchronous-FIFO
*** Results can be found in AsynchFIFO_Results.pdf file <br>
1.asyncfifo.v is a top level module in which all sub module are instantiated.<br>
2.fifmem.v is a fifo memory buffer which is a dual pot RAM.<br>
3.r2w_sync.v file has code for synchronising read pointer to write clock domain.<br>
4.w2r_sync.v file has code for synchronising write pointer to read clock domain.<br>
5.rptr_empty.v contains logic to generate empty signal based on read pointer and synchronised write pointer.<br>
6.wptr_full.v contains logic to generate full signal based on write pointer and synchronised read pointer.<br>
7.tb_async_fifo.v is testbench used for verifying the design of asynchrounous fifo.<br>
![image](https://github.com/user-attachments/assets/ea536b55-6eab-48ab-aac5-1f11efb9f76a) <br>
This image will give an overall idea how Asynchrounous FIFO works and how verilog files are interdependent.

