// structural model of datapath extracted from datapath.mag
// created by ext2svmod 7.0

module datapath(
	output nBorrow ,
	output nZ ,
	output [7:0] Quotient ,
	output [7:0] Remainder ,
	output SDO ,
	input Clock ,
	input Load ,
	input LoadAcc ,
	input LoadResult ,
	input nBorrowIn ,
	input nReset ,
	input nZIn ,
	input [7:0] Operand1 ,
	input [7:0] Operand2 ,
	input SDI ,
	input ShiftIn ,
	input ShiftInDH ,
	input Test 
	);

timeunit 1ns;
timeprecision 10ps;

  wire  [7:0] ACC ;
  wire  [7:0] DivisorH ;
  wire  [7:0] DivisorL ;
  wire  [7:0] Result ;

// include netlist information from datapath.vnet

`include "../extracted/datapath.vnet"

  assign ACC      = {\bitslice_7/ACC , \bitslice_6/ACC , \bitslice_5/ACC , \bitslice_4/ACC , \bitslice_3/ACC , \bitslice_2/ACC , \bitslice_1/ACC , \bitslice_0/ACC };
  assign DivisorH = {DivisorH_7, DivisorH_6, DivisorH_5, DivisorH_4, DivisorH_3, DivisorH_2, DivisorH_1, DivisorH_0};
  assign DivisorL = {DivisorL_7, DivisorL_6, DivisorL_5, DivisorL_4, DivisorL_3, DivisorL_2, DivisorL_1, DivisorL_0};
  assign Result = {Result_7, Result_6, Result_5, Result_4, Result_3, Result_2, Result_1, Result_0};

endmodule
