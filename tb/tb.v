module tb;
 
    reg clk = 0;
    reg start = 0;
    reg [7:0] tx_in;
    wire [7:0] rx_out;
    wire rx_done, tx_done;
 
    wire txrx;
   
    // Positional mapping kept exactly the same
    top dut (   .clk(clk), .start(start), .tx_in(tx_in), .tx(txrx), 
    .rx(txrx), .rx_out(rx_out), .rx_done(rx_done), .tx_done(tx_done ));

    integer i = 0;
 
    initial 
    begin
      start = 1;
      for(i = 0; i < 10; i = i + 1) begin
        tx_in = $urandom_range(10 , 200);
        @(posedge rx_done);
        @(posedge tx_done);
      end
      $stop; 
    end
 
    always #5 clk = ~clk;
 
endmodule