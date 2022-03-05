`timescale 1ns / 1ps

module sobel_filter(
    input valid,
    input  [7:0]  p1, p2, p3, p4, p5, p6, p7, p8, p9,
    output reg [9:0] G
    );
   
function [9:0]  mag;
    input [9:0] a ;
     begin 
         mag = (a[9]==1)?(~a+1) : a;
     end
endfunction
wire [9:0] fac1, fac2, mag_fac1, mag_fac2;
     assign fac1 = ({2'b00,p1}+{1'b0,p2,1'b0}+{2'b00,p3})-({2'b00,p7}+{1'b0,p8,1'b0}+{2'b00,p9});
     assign fac2 = ({2'b00,p3}+{1'b0,p6,1'b0}+{2'b00,p9})-({2'b00,p1}+{1'b0,p4,1'b0}+{2'b00,p7});
     assign mag_fac1 = mag(fac1);
     assign mag_fac2 = mag(fac2);
always @ (*) begin
    if(valid) begin
     G = mag_fac1+mag_fac2 ;
     end
end

endmodule
 