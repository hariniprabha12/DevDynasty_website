module four_bit_adder_tb;
   reg [3:0] a,b;
   reg c;
   wire [3:0] sum; 
   wire carry;

four_bit_adder uut(
    .A(a),
    .B(b),
    .C(c),
    .S(sum),
    .X(carry)
);

initial begin
   a =4'b0000 ; b=4'b0000 ; c=0 ; #10;
   a =4'b1111 ; b=4'b1111 ; c=1 ; #10;
   a =4'b0001 ; b=4'b0001 ; c=0 ; #10;
$finish;
end

initial begin
 $monitor("A =%b , B=%b , Cin=%b , Sum=%d , Carry=%b" , a,b,c,sum,carry);
end 
endmodule