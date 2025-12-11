module full_adder_tb;
    reg a,b,c;
    wire sum , carry;

full_adder uut(
    .A(a),
    .B(b),
    .C(c),
    .S(sum),
    .X(carry)
);

initial begin
   a=0 ; b=0 ; c=0; #10;
   a=0 ; b=0 ; c=1; #10;
   a=0 ; b=1 ; c=0; #10;
   a=0 ; b=1 ; c=1; #10;
   a=1 ; b=0 ; c=0; #10;
   a=1 ; b=0 ; c=1; #10;
   a=1 ; b=1 ; c=0; #10;
   a=1 ; b=1 ; c=1; #10;
$finish;
end

initial begin
  $monitor("A=%b , B=%b , C=%b , Sum =%b , Carry=%b" , a,b,c,sum,carry);
end 
endmodule
   
 