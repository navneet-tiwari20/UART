`timescale 1ns / 1ps 
 
module top(
    input clk,
    input start,
    input [7:0] tx_in,
    output reg tx, 
    input rx,
    output [7:0] rx_out,
    output rx_done, tx_done
    );
    
 parameter clk_value = 100_000;
 parameter baud = 9600;
 
 parameter wait_count = clk_value / baud;
 
 reg bit_done = 0;
 integer count = 0;
 parameter idle = 0, send = 1, check = 2;
 reg [1:0] state = idle;
 
///////////////////Generate Trigger for Baud Rate
 always@(posedge clk)
 begin
  if(state == idle)
    begin 
    count <= 0;
    end
  else begin
    if(count == wait_count)
       begin
        bit_done <= 1'b1;
        count   <= 0;  
       end
    else
       begin
       count   <= count + 1;
       bit_done <= 1'b0;  
      end    
  end
 
 end
 
 ///////////////////////TX Logic
 reg [9:0] tx_data;///stop bit data start
 integer bit_index = 0; ///reg [3:0];
 reg [9:0] shift_tx = 0;
 
 
 always@(posedge clk)
 begin
 case(state)
 idle : 
     begin
           tx        <= 1'b1;
           tx_data   <= 0;
           bit_index <= 0;
           shift_tx  <= 0;
           
            if(start == 1'b1)
              begin
                tx_data <= {1'b1,tx_in,1'b0};
                state   <= send;
              end
            else
              begin           
               state <= idle;
              end
     end
 
  send: begin
           tx        <= tx_data[bit_index];
           state     <= check;
           shift_tx  <= {tx_data[bit_index], shift_tx[9:1]};
  end 
  
  check: 
  begin
               if(bit_index <= 9) ///0 - 9 = 10
                  begin
                    if(bit_done == 1'b1)
                     begin
                     state     <= send;
                     bit_index <= bit_index + 1;
                     end
                 end
                else
                begin
                state     <= idle;
                bit_index <= 0;
                end
            end
 
 default: state <= idle;
 
 endcase
 
 end
 
assign tx_done = (bit_index == 9 && bit_done == 1'b1) ? 1'b1 : 1'b0;
 
 
 ////////////////////////////////RX Logic
 integer rcount = 0;
 integer rindex = 0;
 parameter ridle = 0, rwait = 1, recv = 2, rcheck = 3;
 reg [1:0] rstate;
 reg [9:0] rx_data;
 always@(posedge clk)
 begin
 case(rstate)
 ridle : 
     begin
      rx_data <= 0;
      rindex  <= 0;
      rcount  <= 0;
        
         if(rx == 1'b0)
          begin
           rstate <= rwait;
          end
         else
           begin
           rstate <= ridle;
           end
     end
     
rwait : 
begin
      if(rcount < wait_count / 2)
         begin
          rcount <= rcount + 1;
          rstate <= rwait;
         end
     else
       begin
          rcount  <= 0;
          rstate  <= recv;
          rx_data <= {rx,rx_data[9:1]}; 
       end
end
 
 
recv : 
begin
     if(rindex <= 9) 
      begin
      if(bit_done == 1'b1) 
        begin
        rindex <= rindex + 1;
        rstate <= rwait;
        end
      end
      else
        begin
        rstate <= ridle;
        rindex <= 0;
        end
end
 
 
default : rstate <= ridle;
 
 
 endcase
 end
 
 
assign rx_out  = rx_data[8:1]; 
assign rx_done = (rindex == 9 && bit_done == 1'b1) ? 1'b1 : 1'b0;
 
 
 endmodule
 //////////////////////////////////
