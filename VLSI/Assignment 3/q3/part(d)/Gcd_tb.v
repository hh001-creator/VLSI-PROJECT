`include "Gcd.v"
module GCD_tb();
    reg [5:0] A , B;
    output [5:0] C;
    reg clk , reset;
    GCD Gcd1(clk , A , B , reset , C);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0 , GCD_tb);
    end 

    initial clk = 1;
    always #5 clk = ~clk;
    initial begin
        A = 24;
        B = 16;
        reset = 0;
        #200 $finish;
    end


endmodule