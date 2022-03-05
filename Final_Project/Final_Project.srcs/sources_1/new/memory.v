`timescale 1ns / 1ps

module rom_memory (
address,
read_en,
clk,
data
 );
 
  input [13:0] address ; 
  input read_en ;
  input clk;
  output reg [7:0] data;
  
  reg [7:0] mem [0:16383] ;  

  initial begin
   $readmemb("memory.mem", mem); 
 end
 
 always @(posedge clk)
    data = (read_en) ? mem[address] : 8'b0 ;

 endmodule
