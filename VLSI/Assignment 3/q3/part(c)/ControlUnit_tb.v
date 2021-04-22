`include "ControlUnit.v"

module test ();
    reg K1 , K2 , clk , reset; //K1 = (XR > 0) , K2 = (XR >= YR)
    wire reg subract , swap , selectxy , loadxr , loadyr;
    wire reg [1:0] present , next;
    initial clk = 0;
    always #2 clk = ~clk;
    ControlUnit C1(K1 , K2 , clk , reset , 
                  subract , swap ,selectxy , loadxr , loadyr,present , next);
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0 , test);
        
    end
    initial begin
        reset = 0;
        K1 = 0;K2 = 0;
        #40 $finish;
    end
    always #1 K1 = ~K1;
    always #2 K2 = ~K2;
       
endmodule