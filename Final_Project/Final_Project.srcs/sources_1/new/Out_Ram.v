`timescale 1ns / 1ps

module out_ram (
clk, 
address, 
write_data,  
write_enable 
          
); 

input   clk;
input [13:0] address;
input write_enable;
input [7:0]  write_data;

 
reg [7:0] mem2 [0:16383];

  initial begin
   $readmemb("mem2.mem", mem2); 
 end

always @ (posedge clk)
begin 
   if ( write_enable ) begin
       mem2[address] = write_data;
   end
   else begin 
   mem2[address] =8'b0;
   end
end

endmodule 