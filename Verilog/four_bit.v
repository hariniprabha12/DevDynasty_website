module four_bit_adder(A, B, C, S, X);
 input [3:0] A , B ;
 input C;
 output [3:0] S;
 output X;
 wire c1 , c2 ,c3 ;
 full_adder f1 (.A(A[0]), .B(B[0]), .C(C), .S(S[0]), .X(c1));
 full_adder f2 (.A(A[1]), .B(B[1]), .C(c1), .S(S[1]), .X(c2));
 full_adder f3 (.A(A[2]), .B(B[2]), .C(c2), .S(S[2]), .X(c3));
 full_adder f4 (.A(A[3]), .B(B[3]), .C(c3), .S(S[3]), .X(X));
 endmodule