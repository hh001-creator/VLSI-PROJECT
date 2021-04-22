`include "Datapath.v"

module DP_tb() ;
	
	reg reset , clock , Subtract , Swap , LoadXR , LoadYR , SelectXY ;
	reg [5:0] X , Y ;
	wire [5:0] Z , XR , YR ;
	wire XR_gt_YR , XR_gt_0 ;
	integer cnt ;
	
	initial 
		begin
			$dumpfile("DP_tb.vcd") ;
			$dumpvars(0,DP_tb) ;
		end	
	
	DataPath DUT ( Z , XR_gt_YR , XR_gt_0 , XR , YR ,  X , Y , reset , Subtract , Swap , SelectXY , LoadXR , LoadYR , clock) ;
	
	initial
		begin
			reset = 1 ;
			Subtract = 0 ;
			Swap = 0 ;
			SelectXY = 1 ;
			LoadXR = 1 ;
			LoadYR = 1 ;
			X = 1 ;
			Y = 2 ;
			#6
			reset = 0 ;
            #200 $finish;
		end
	initial clock = 1;
	always #5 clock = ~clock;
endmodule