module pro_tb;
    reg clk;
    reg rst;
    reg [10:0] inst;

processor uut (
    .clk(clk),
    .rst(rst),
    .inst(inst)
);

always #10 clk = ~clk;

initial begin
    $dumpfile("prowaveform.vcd");
    $dumpvars(0, pro_tb);

    clk = 0;
    rst = 0;
    inst = 11'b00000000000;
    #10 rst = 1;

    inst = 11'b00000011000;
#60;

    inst = 11'b00100010100;
#60;

    inst = 11'b10100010011;
#60;

    $finish;
end

initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | inst=%b", $time, clk, rst, inst);
end
endmodule
