module inst_dec(clk,rst,inst,carry,rwn,csn,opcod,op1,op2);
   input clk ,rst ;
   input [10:0] inst ;
   output reg carry ,rwn, csn ;
   output reg [2:0] opcod ;
   output reg [3:0] op1 ,op2;
   reg [1:0] state ;

   
   parameter
     init = 2'b00  , fetch = 2'b01  , execute = 2'b10 , store = 2'b11 ;

   always @ (posedge clk or negedge rst)
   begin   
     if (!rst) begin 
        state <= init;
        op1 <= 4'b0000;
        op2 <= 4'b0000;
        opcod <= 3'b000;
        csn <= 1'b1; 

      end 

      else begin 
          case(state) 
             init : begin 
                 state <= fetch;
                 opcod <= inst[10:8];
                 op1 <= inst[7:4];
                 op2 <= inst[3:0];
                 csn <= 1'b0;
                 rwn <= 1'b1;
                 end 
             fetch : begin
                 state <= execute;
                 csn <= 1'b1;
                 if (opcod == 3'd2) begin
                     carry <= 1'b1;
                 end 
                 else begin
                     carry <= 1'b0;
                 end 
                 end
             execute : begin
                 state <= store;
                 csn <= 1'b0;
                 rwn <= 1'b0;
               end 
             store : begin 
                 state <= fetch;
                 state <= fetch;
                 opcod <= inst[10:8];
                 op1 <= inst[7:4];
                 op2 <= inst[3:0];
                 csn <= 1'b0;
                 rwn <= 1'b1;
               end 
            endcase 
         end
     end               
endmodule             


                 
            
             

