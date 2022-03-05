`timescale 1ns / 1ps

module top(
    input clk, reset,start,
    output [9:0] G,
    output filter_done
    );
    //filter variables
    wire [7:0] p1, p2,p3, p4; 
           //, p5, p6, p7, p8, p9;    

    //gray_scale outbut
    wire [7:0] p1_c, p2_c,p3_c, p4_c , p5_c, p6_c, p7_c, p8_c, p9_c;    
    
    //rom variables
    wire [9:0] rom_data;
    wire rom_re_e;
    wire [13:0] rom_address;
    
    //controller variables
    wire valid;
    wire write_E;
    wire [13:0] write_address;
    wire [9:0] write_data;
    
    //Camera variables
    wire sioc;
    wire siod;
    wire done;
     
    
camera_configure camera_configure_ins (clk,start,sioc,siod,done);
rom_memory i_rom_memory(rom_address, rom_re_e, clk, rom_data);
//sobel_filter i_sobel_filter(valid,p1_c, p2_c,p3_c, p4_c , p5_c, p6_c, p7_c, p8_c, p9_c,G);
//gray_scale_converter i_gray_scale_converter1(p1,p2,p3,p4,p5,p6,p7,p8,p9,p1_c, p2_c,p3_c, p4_c , p5_c, p6_c, p7_c, p8_c, p9_c);

robert_filter i_robert_filter(valid,p1,p2,p3,p4,G);

//sobel_controller i_sobel_controller(clk, reset,done, rom_data, rom_re_e,write_E,write_address,rom_address, p1, p2, p3, p4, p5, p6, p7, p8, p9,valid,G,write_data,filter_done );
ropert_controller i_ropert_controller(clk, reset,done, rom_data, rom_re_e,write_E,write_address,rom_address, p1, p2, p3, p4,valid,G,write_data,filter_done );

//OUT_RAM_CONTROLLER OUT_RAM_CONTROLLER_i(clk, reset,G,write_data,write_E,write_address,filter_done);

out_ram i_out_ram (clk, write_address,write_data,write_E);
endmodule
