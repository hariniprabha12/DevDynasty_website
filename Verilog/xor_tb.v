module xor_gate_tb;
   reg A, B;
   wire Y;

xor_gate uut(
    .a(A),
    .b(B),
    .y(Y)
);
 
initial begin 
    A=0 ; B=0 ; #10;
    $display ("A=%b, B=%b, Y=%b ", A,B,Y);

    A=0 ; B=1 ; #10;
    $display ("A=%b, B=%b, Y=%b ", A,B,Y);

    A=1 ; B=0 ; #10;
    $display ("A=%b , B=%b, Y=%b", A,B,Y);
    
    A=1 ; B=1 ; #10;
    $display ("A=%b , B=%b, Y=%b ", A,B,Y);
 $finish ;
 end
 endmodule