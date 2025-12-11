module full_adder(A,B,C,S,X);
  input A,B,C;
  output S,X;
  wire D,E,G,F;
  xor_gate f1 (.a(A), .b(B), .y(D));
  xor_gate f2 (.a(D), .b(C), .y(S));
  assign E = A&B;
  xor_gate f3 (.a(A), .b(B), .y(G));
  assign F = G&C;
  assign X = F|E;
endmodule

