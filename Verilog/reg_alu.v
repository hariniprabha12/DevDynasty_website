module reg_alu(A,B,S,Cin,F,C,clk,rst);
  input [3:0] A,B;
  input [2:0] S;
  input Cin;
  input clk ,rst;
  output reg [3:0] F;
  output reg C;
  wire [3:0] X,sum_out;
  wire Cout;
  reg [3:0] tempA , tempB ;

  xor_gate f0 (.a(A[0]), .b(B[0]), .y(X[0]));
  xor_gate f1 (.a(A[1]), .b(B[1]), .y(X[1]));
  xor_gate f2 (.a(A[2]), .b(B[2]), .y(X[2]));
  xor_gate f3 (.a(A[3]), .b(B[3]), .y(X[3]));

  always @(*) begin
   case(S) 
     3'b000: begin tempA = 4'b0000; tempB= B; end
     3'b001: begin tempA = A ;tempB = B; end
     3'b010: begin tempA = A ;tempB = ~B; end
     3'b011: begin tempA = A ;tempB = 4'b1111; end
     3'b100: begin tempA = A ;tempB = A|B; end
     3'b101: begin tempB = X; end
     3'b110: begin tempB = A&B; end
     3'b111: begin tempB = ~A; end
 endcase
     end
     four_bit_adder r1 (.A(tempA), .B(tempB), .C(Cin), .S(sum_out), .X(Cout));
 always @(posedge clk or negedge rst)begin
   if (rst) begin
     F <= (S <=3'b011) ? sum_out : tempB;
     C <= (S <=3'b011) ? Cout : 1'b0;
     end
   else begin
    F <= 4'b0000;
    C <= 1'b0;
    end
end

endmodule




















































































































































































































    
