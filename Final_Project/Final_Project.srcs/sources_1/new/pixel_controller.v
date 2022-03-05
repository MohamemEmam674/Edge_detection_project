`timescale 1ns / 1ps

module sobel_controller(
    input clk, reset,
    input con_done,
    input [7:0] rom_data,
    output  rom_re_e,
    output  reg write_enable,
    output reg  [13:0] write_address,
    output  [13:0] rom_address,
    output reg  [7:0]  p1, p2, p3, p4, p5, p6, p7, p8, p9,
    output reg valid_reg,
    input [9:0] G ,
    output reg [9:0] write_data,
    output reg  filter_done
    );
    
    reg valid;
    reg [13:0] write_address_shifted;
    reg [6:0] raw_counter, col_counter;
    reg [14:0] pixel_counter;
    reg[14:0] index_counter ;
    reg [13:0] write_counter ;

always @ (posedge clk,con_done) begin
     p1 <= (pixel_counter == index_counter+1 )?rom_data : p1;
     p2 <= (pixel_counter ==index_counter+ 2 )?rom_data : p2;
     p3 <= (pixel_counter ==index_counter+ 3 )?rom_data : p3;
     p4 <= (pixel_counter ==index_counter+ 4 )?rom_data : p4;
     p5 <= (pixel_counter ==index_counter+ 5 )?rom_data : p5;
     p6 <= (pixel_counter ==index_counter+ 6 )?rom_data : p6;
     p7 <= (pixel_counter ==index_counter+ 7 )?rom_data : p7;
     p8 <= (pixel_counter ==index_counter+ 8 )?rom_data : p8;
     p9 <= (pixel_counter ==index_counter+ 0 )?rom_data : p9;
     valid_reg <= valid;
    write_data<=G ;
     write_address <= write_address_shifted;
      if (write_address_shifted<129 ||write_address_shifted>16254 ) begin
        write_data<=8'b0 ;
        write_enable <=0 ;
        filter_done <= (write_address_shifted==16382)?1:0 ;
      end
      else begin
      write_data<=G ;
      filter_done <= 0 ;
      write_enable <=1 ;
      end
    end
    
    assign   rom_re_e =1;          
             
   assign rom_address =(pixel_counter<index_counter+3)? 
   pixel_counter+raw_counter:
   ((pixel_counter>index_counter+2 && pixel_counter<index_counter+6)?
    pixel_counter+raw_counter+125:pixel_counter+raw_counter+250);
    
    always @(posedge clk,con_done) begin 
        if(reset) begin
            pixel_counter <= 0;
            index_counter <= 0 ;
            raw_counter <= 0;
            col_counter <= 0;
            valid<=0;
            filter_done <= 0 ;
            write_address_shifted <= 128;
            write_counter <= 128;
            write_enable <=0 ;
        end
        else begin    
           if (pixel_counter==index_counter+8) begin
                    pixel_counter <= index_counter ;
                    write_address_shifted <= write_address_shifted+1;
                        if(write_address_shifted==write_counter+126) begin
                             write_address_shifted <= write_address_shifted+3;
                             write_counter<=write_counter+128;
                        end 
                     if(raw_counter==125) begin
                        raw_counter <= 0 ;
                        col_counter<=col_counter+1;
                        index_counter <= col_counter*128 ;     
                        pixel_counter <= col_counter*128 ;
                     end
                         else begin 
                         raw_counter <= raw_counter+1;
                         col_counter <= col_counter ;
                         valid<=1;
                         end
                end
                else begin
                   pixel_counter<=pixel_counter+1;
                   raw_counter <= raw_counter;
                   valid<=0;
                end
       end
   end
   
endmodule
