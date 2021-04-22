`include "behavioralgcd.v"
module gcd_behavioraltb();
	
    reg [15:0] AR , BR , AR1 , BR1;
    wire [15:0] out , out1;
    
    GCD_behavioral#(16) gcd_unit(AR , BR , out);
    initial begin
        $dumpvars(0 , gcd_behavioraltb);
        $dumpfile("dump.vcd");
    end
    initial begin
        AR = 27; BR = 19;
        #10;
        $display("gcd(27 , 19) = %x",out);
        $finish;
    end
    GCD_behavioral#(16) gcd_unit1(AR1 , BR1 , out1);
    initial begin
        AR1 = 24; BR1 = 16;
        #10;
        $display("gcd(24 , 16) = %x",out1);
        $finish;
    end
endmodule
