module alu(A,B,S,Cin,F,C);
  input [3:0] A,B;
  input [2:0] S;
  input Cin;
  output [3:0] F;
  output C;
  wire [3:0] X,sum_out;
  wire Cout;
  reg [3:0] temp;

  xor_gate f0 (.a(A[0]), .b(B[0]), .y(X[0]));
  xor_gate f1 (.a(A[1]), .b(B[1]), .y(X[1]));
  xor_gate f2 (.a(A[2]), .b(B[2]), .y(X[2]));
  xor_gate f3 (.a(A[3]), .b(B[3]), .y(X[3]));

  always @(*) begin
   case(S) 
     3'b000: temp = 4'b0000;
     3'b001: temp = B;
     3'b010: temp = ~B;
     3'b011: temp = 4'b1111;
     3'b100: temp = A|B;
     3'b101: temp = X;
     3'b110: temp = A&B;
     3'b111: temp = ~A;
 endcase
     end
     four_bit_adder r1 (.A(A), .B(temp), .C(Cin), .S(sum_out), .X(Cout));
     assign F = (S <=3'b011) ? sum_out : temp;
     assign C = (S <=3'b011) ? Cout : 1'b0;

endmodule




















































































































































































































    
