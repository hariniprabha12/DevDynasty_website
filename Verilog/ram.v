module ram(addr,datain,csn,rwn,dataout,clk,rst);
  input [3:0] addr,datain;
  input csn , rwn ,clk ,rst;
  output reg  [3:0]  dataout;
  reg [3:0] mem [15:0];
  integer i;

  
  always@(posedge clk or negegde rst)begin
   if(!rst) begin
         for(i=0;i<16;i++) begin
            mem[i] = 4'b0000;
         end
         dataout = 4'b0000;
      end
   else  begin
      if(!csn) begin
         if(rwn) begin
            dataout <= mem[addr];
         end 
         else begin
            mem[addr] <= datain;
            dataout <= 4'bz;
         end
      end
      else begin
      dataout <= 4'bz;
      end
   end

end 
endmodule
