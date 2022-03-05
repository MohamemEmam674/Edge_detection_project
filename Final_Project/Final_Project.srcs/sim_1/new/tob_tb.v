`timescale 1ns / 1ps

module top_tb();
    integer i,frame ;
    reg clk, reset,start;
    wire [9:0] G;
    wire filter_done;
    top i_top(  clk, reset,start, G,filter_done  );
    
    initial begin
    clk = 0;
    reset =1;
    #20 reset=0;
    start = 0;
    #100;
    start = 1;
    #10;
    start = 0;
    end
    always #10 clk=~clk;

 initial begin
frame = $fopen("memory2.mem","w");
while(filter_done !== 1'b1) begin
	#50;
end
$display ("filter_done... %d, 	%0t",filter_done,$time);
for (i = 0; i<128*128; i=i+1) begin
 #10 $fwrite(frame,"%b\n",i_top.i_out_ram.mem2[i]);
end
$fclose(frame);
end
endmodule
