module ram_tb;
 reg clk , rst;
 reg [3:0] addr,datain;
 reg csn,rwn;
 wire [3:0] dataout;

 ram uut(
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .datain(datain),
    .csn(csn),
    .rwn(rwn),
    .dataout(dataout)
 );
 always #10 clk = ~clk;

 initial begin
   $dumpfile("waveform.vcd");
   $dumpvars(0,ram_tb);
   clk =0;
   rst =0;
   addr = 4'b0000;
   datain = 4'b0000;
   csn =1;
   rwn =1;
   #20 rst =1;
       
        #20 csn = 0; rwn = 0; addr = 4'b0001; datain = 4'b0010;
        #20 csn = 0; rwn = 1; addr = 4'b0001;  
        #20 csn = 0; rwn = 0; addr = 4'b0010; datain = 4'b0100;
        #20 csn = 0; rwn = 1; addr = 4'b0010;
        #20 csn = 0; rwn = 0; addr = 4'b0011; datain = 4'b0011;
        #20 csn = 0; rwn = 1; addr = 4'b0011;

        #20 csn = 1;
        #20 $finish;
    end
    initial begin
        #10;$monitor("Time: %0t | clk: %b | rst: %b | csn: %b | rwn: %b | addr: %d | datain: %d | dataout: %d", $time, clk, rst, csn, rwn, addr, datain, dataout);
    end
endmodule

