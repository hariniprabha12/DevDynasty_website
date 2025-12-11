module reg_alu_tb;
  reg [3:0] a,b;
  reg [2:0] s;
  reg cin, clk ,rst;
  wire [3:0] f;
  wire cout;

  reg_alu uut (
    .A(a),
    .B(b),
    .Cin(cin),
    .clk(clk),
    .rst(rst),
    .S(s),
    .F(f),
    .C(cout)
  );
 
  always #10 clk =~clk;
  always #10 rst =~rst;
  initial begin 
  clk=0;
  rst=0;
  #20 rst=1;
  end
  initial begin
     a= 4'b0010 ; b= 4'b0001 ; s=3'b000 ; cin=0 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b000 ; cin=1 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b001 ; cin=0 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b001 ; cin=1 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b010 ; cin=0 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b010 ; cin=1 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b011 ; cin=0 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b011 ; cin=1 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b100 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b101 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b110 ; #20;
     a= 4'b0010 ; b= 4'b0001 ; s=3'b111 ; #20;
     $finish;
    end

  initial begin 
  $monitor("time=%0t|rst=%b| A=%d , B=%d , Cin= %d , S=%d , F=%d ,Cout=%b",$time,rst,a,b,cin,s,f,cout);#20;
  end 
endmodule