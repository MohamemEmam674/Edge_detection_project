`timescale 1ns / 1ps

module robert_filter(
    input valid,
    input  [7:0]  p1, p2, p3, p4,
    output reg [9:0] G
    );
   
function [9:0]  mag;
    input [9:0] a ;
     begin 
         mag = (a[9]==1)?(~a+1) : a;
     end
endfunction
wire [9:0] fac1, fac2, mag_fac1, mag_fac2;
     assign fac1 = {2'b00,p1}-{2'b00,p4};
     assign fac2 = {2'b00,p2}-{2'b00,p3};
     assign mag_fac1 = mag(fac1);
     assign mag_fac2 = mag(fac2);
always @ (*) begin
    if(valid) begin
     G = mag_fac1+mag_fac2 ;
     end
end

endmodule
 