`timescale 1ns / 1ps

module gray_scale_converter(
    input [7:0] p1, p2,p3, p4 , p5, p6, p7, p8, p9,
    output [7:0] p1_c, p2_c,p3_c, p4_c , p5_c, p6_c, p7_c, p8_c, p9_c
    );
    reg [7:0]r,g,r1,r2,g1,g2;
    reg [7:0]b,b1,b2;
    function [7:0]  gray;
    input [7:0] a ;
     begin 
     r={a[7:5],5'b00000};
     g={3'b000,a[4:2],2'b00};
     b={6'b000000,a[1:0]};
//     r1=r>>2;
//     r2=r>>5;
//     g1=g>>1;
//     g2=g>>4;  
//     b1=b>>4;
//     b2=b>>5;
//     gray= r1 + r2 + g1+ g2 + b1 +b2
//     gray = (r * 0.299 + g * 0.587 + b * 0.114);
//b = a & 3;
//g = (a >> 2) & 7;
//r = a >> 5;
gray = r>>5+g>>2+b;
     
     end
endfunction
    
    assign p1_c =gray(p1);
    assign p2_c =gray(p2) ;
    assign p3_c =gray(p3) ;
    assign p4_c =gray(p4) ;
    assign p5_c =gray(p5) ;
    assign p6_c =gray(p6) ;
    assign p7_c =gray(p7) ;
    assign p8_c =gray(p8) ;
    assign p9_c =gray(p9) ;

endmodule
