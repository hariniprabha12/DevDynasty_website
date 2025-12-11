module inst_dec_tb;
    reg clk, rst;
    reg [10:0] inst;
    wire [3:0] dataout , op1 ,op2 ;
    wire [2:0] opcod;
    wire carry, rwn, csn;

    inst_dec uut (
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .dataout(dataout),
        .carry(carry),
        .rwn(rwn),
        .csn(csn),
        .opcod(opcod),
        .op1(op1),
        .op2(op2)
    );

    always #5 clk = ~clk; 
    initial begin
        $dumpfile("inst_dec_tb.vcd"); 
        $dumpvars(0, inst_dec_tb);

        clk = 0;
        rst = 0;
        inst = 11'b000_0000_0000; 
        #10 rst = 1; 
        inst = 11'b000_0001_0010; #40;
        inst = 11'b010_0011_0001; #40;
    
        $finish;
    end
    initial begin
       $monitor("time = %0t, opcode= %b ,instruction=%b, op1= %b, op2= %b , carry = %b ,rwn= %b , csn = %b",
                  $time, opcod, inst,op1, op2, carry, rwn, csn);
    end
endmodule
