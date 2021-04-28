D flip-flop netlist

.include TSMC_180nm.txt

.param LAMBDA = 0.09u
.global vdd gnd

VDD vdd gnd 1.8

Vin1 D       gnd pulse( 0 1.8 0.1ns 0ps 0ps 0.4ns 0.8ns 0 )
Vin2 Clk     gnd pulse( 0 1.8 0.2ns 0ps 0ps 0.2ns 0.4ns 0 )
Vin3 Clk_bar gnd pulse( 1.8 0 0.2ns 0ps 0ps 0.2ns 0.4ns 0 )

.subckt d_latch out in clk clk_bar pow grnd
	
.param width_N = {10*LAMBDA}
.param width_P = {2*width_N}

Mn1 n1  in      grnd grnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
Mn2 out Clk_bar n1   grnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
Mp1 n2  in      pow  pow  CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
Mp2 out Clk     n2   pow  CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

.ends d_latch

.subckt inv out in pow grnd
	
.param width_N = {10*LAMBDA}
.param width_P = {2*width_N}

Mn out in grnd grnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}  
Mp out in pow  pow  CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
	
.ends inv

xD1 out1 D clk clk_bar vdd gnd d_latch
xD2 Q out1 clk_bar clk vdd gnd d_latch

xI1 out Q vdd gnd inv

.tran 1ps 2ns

.measure tran fall_Q
+TRIG v(D) VAL = '0.5*1.8' FALL = 1
+TARG v(Q) VAL = '0.5*1.8' FALL = 1
.measure tran rise_Q
+TRIG v(D) VAL = '0.5*1.8' RISE = 1
+TARG v(Q) VAL = '0.5*1.8' RISE = 1
.measure tran delay_Q param = '(fall_Q+rise_Q)/2' goal = 0

.measure tran fall_out1
+TRIG v(D) VAL = '0.5*1.8' RISE = 1
+TARG v(out1) VAL = '0.5*1.8' FALL = 1
.measure tran rise_out1
+TRIG v(D) VAL = '0.5*1.8' FALL = 1
+TARG v(out1) VAL = '0.5*1.8' RISE = 1
.measure tran delay_out1 param = '(fall_out1+rise_out1)/2' goal = 0

.measure tran fall_out
+TRIG v(D) VAL = '0.5*1.8' RISE = 1
+TARG v(out) VAL = '0.5*1.8' FALL = 1
.measure tran rise_out
+TRIG v(D) VAL = '0.5*1.8' FALL = 1
+TARG v(out) VAL = '0.5*1.8' RISE = 1
.measure tran delay_out param = '(fall_out+rise_out)/2' goal = 0

.control

	set hcopypscolor = 1
	set color0 = white
	set color1 = black
	
	run
	
	plot D
	
	plot out1

	plot Q

	plot out	
		
	plot clk

.endc
