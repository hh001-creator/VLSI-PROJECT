D flip-flop netlist

.include TSMC_180nm.txt

.param LAMBDA = 0.09u
.param width_N = {10*LAMBDA}
.param width_P = {5*width_N}
.global gnd vdd

VDD vdd gnd 1.8

Vin1 D       gnd pulse( 0 1.8 1ns 0ps 0ps 10ns 20ns 0 )
Vin2 Clk     gnd pulse( 0 1.8 1ns 0ps 0ps 2.5ns 5ns 0 )
*Vin3 Clk_bar gnd pulse( 1.8 0 0ns 0ps 0ps 1ns 2ns 0 )

.subckt cmosinv out in hi lo 
M1 out in lo lo 
+ CMOSN W={width_N} L={2*LAMBDA} 
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} 
+ AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M2 out in hi hi 
+ CMOSP W={width_P} L={2*LAMBDA} 
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} 
+ AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

.ends cmosinv

.subckt cmosnand out in1 in2 hi lo
M1 out in1 hi hi 
+ CMOSP W={width_P} L={2*LAMBDA} 
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} 
+ AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M2 out in2 hi hi
+ CMOSP W={width_P} L={2*LAMBDA} 
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} 
+ AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M3 out in1 C gnd
+ CMOSN W={width_N} L={2*LAMBDA} 
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} 
+ AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M4 C in2 gnd gnd
+ CMOSN W={width_N} L={2*LAMBDA} 
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} 
+ AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

.ends cmosnand

xI1 D_bar D vdd gnd cmosinv
xN1 o1 D clk vdd gnd cmosnand
xN2 o2 D_bar clk vdd gnd cmosnand

xN3 Q o1 Q_bar vdd gnd cmosnand
xN4 Q_bar o2 Q vdd gnd cmosnand
.ic v(Q) = 1.8 v(Q_bar) = 0
.tran 10ps 50ns

*.measure tran fall_n2
*+TRIG v(D)  VAL = '0.5*1.8' RISE = 1
*+TARG v(n2) VAL = '0.5*1.8' FALL = 1
*.measure tran rise_n2
*+TRIG v(D)  VAL = '0.5*1.8' FALL = 1
*+TARG v(n2) VAL = '0.5*1.8' RISE = 1
.control
	
	set hcopypscolor = 1
	set color0 = white
	set color1 = black
	
	run
	
	plot D

	plot Clk

	plot Q
	
.endc
