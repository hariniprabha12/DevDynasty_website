module processor(inst, clk, rst);
   input clk , rst ;
   input [10:0] inst;
   wire carry , cout;
   wire [2:0] opcod;
   wire [3:0] op1,op2;
   wire csn , rwn ;
   wire [3:0] a;
   wire [3:0] data_alu;


   inst_dec f1 (
    .clk(clk),
    .rst(rst),
    .inst(inst),
    .opcod(opcod),
    .op1(op1),
    .op2(op2),
    .csn(csn),
    .rwn(rwn),
    .carry(carry)


   );

   ram f2(
    .addr(op1),
    .datain(data_alu),
    .csn(csn),
    .rwn(rwn),
    .dataout(a),
    .clk(clk),
    .rst(rst)
   );

reg_alu f3(
    .A(a),
    .B(op2),
    .S(opcod),
    .Cin(carry),
    .clk(clk),
    .rst(rst),
    .F(data_alu),
    .C(cout)
) ;

endmodule

