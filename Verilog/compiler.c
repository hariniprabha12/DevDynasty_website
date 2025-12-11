#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* opcode_convert( char* inst){
   if(strcmp(inst , "sto") == 0) 
       return "000";
   if(strcmp(inst , "add") == 0)
       return "001";
   if(strcmp(inst , "xor") == 0)
       return "101";
}

void binary_convert( int num, int bit , char* binary){
    for (int i = bit-1 ; i >=0 ; i--){
        binary[i] = (num & 1)? '1':'0';
        num >>=1;
    }
    binary[bit] = '\0';
}

int main(){
    FILE *infile , *outfile;
    char inst [10];
    int reg , value;
    char binary_reg[4], binary_value[5];
    
    infile = fopen( "assembly.txt", "r");
    outfile = fopen("pro_tb.v", "w");

     
     fprintf(outfile, "module pro_tb;\n");
     fprintf(outfile, "    reg clk;\n");
     fprintf(outfile, "    reg rst;\n");
     fprintf(outfile, "    reg [10:0] inst;\n\n");
 
     fprintf(outfile, "processor uut (\n");
     fprintf(outfile, "    .clk(clk),\n");
     fprintf(outfile, "    .rst(rst),\n");
     fprintf(outfile, "    .inst(inst)\n");
     fprintf(outfile, ");\n\n");
 
     fprintf(outfile, "always #10 clk = ~clk;\n\n");
 
     fprintf(outfile, "initial begin\n");
     fprintf(outfile, "    $dumpfile(\"prowaveform.vcd\");\n");
     fprintf(outfile, "    $dumpvars(0, pro_tb);\n\n");
 
     fprintf(outfile, "    clk = 0;\n");
     fprintf(outfile, "    rst = 0;\n");
     fprintf(outfile, "    inst = 11'b00000000000;\n");
     fprintf(outfile, "    #10 rst = 1;\n\n");



    while (fscanf(infile, "%s %d %d" ,  inst ,&reg , &value )!= EOF){
        char* opcode = opcode_convert( inst);
        if (opcode == NULL) {
            printf("Warning: Invalid opcode %s, skipping...\n", inst);
            continue;
        }
        binary_convert(reg , 4, binary_reg);
        binary_convert(value , 4, binary_value);
        fprintf(outfile,"    inst = 11'b%.3s%.4s%.4s;\n", opcode , binary_reg , binary_value);
        fprintf(outfile,"#60;\n\n");

    }
    fprintf(outfile, "    $finish;\n");
    fprintf(outfile, "end\n\n");

    fprintf(outfile, "initial begin\n");
    fprintf(outfile, "    $monitor(\"Time=%%0t | clk=%%b | rst=%%b | inst=%%b\", $time, clk, rst, inst);\n");
    fprintf(outfile, "end\n");

    fprintf(outfile, "endmodule\n");

    fclose(infile);
    fclose(outfile);

    printf("Testbench successfully generated: pro_tb.v\n");
    system("iverilog -o processor_sim  processor.v pro_tb.v  inst_dec.v ram.v reg_alu.v four_bit.v adder.v xor.v");
    system("vvp processor_sim");
    system("gtkwave prowaveform.vcd");
    return 0;
}