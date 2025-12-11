module alu_tb;
  reg [3:0] a,b;
  reg [2:0] s;
  reg cin;
  wire [3:0] f;
  wire cout;

  alu uut (
    .A(a),
    .B(b),
    .Cin(cin),
    .S(s),
    .F(f),
    .C(cout)
  );

  initial begin
     a= 4'b1110 ; b= 4'b1010 ; s=3'b000 ; cin=0 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b000 ; cin=1 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b001 ; cin=0 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b001 ; cin=1 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b010 ; cin=0 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b010 ; cin=1 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b011 ; cin=0 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b011 ; cin=1 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b100 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b101 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b110 ; #10;
     a= 4'b1110 ; b= 4'b1010 ; s=3'b111 ; #10;
     $finish;
    end

  initial begin 
  $monitor("A=%b , B=%b , Cin= %b , S=%b , F=%b ,Cout=%b",a,b,cin,s,f,cout);
  end 
endmodule