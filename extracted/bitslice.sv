// structural model of bitslice extracted from bitslice.mag
// created by ext2svmod 8.0

module bitslice(
	output nBorrowOut ,
	output nZOut ,
	output Quotient ,
	output Remainder ,
	output SDO ,
	output SHLoutResult ,
	output SHRoutDH ,
	output SHRoutDL ,
	input Clock ,
	input Load ,
	input LoadAcc ,
	input LoadResult ,
	input nBorrowIn ,
	input nReset ,
	input nZIn ,
	input Operand1 ,
	input Operand2 ,
	input SDI ,
	input SHLinResult ,
	input SHRinDH ,
	input SHRinDL ,
	input Test 
	);

timeunit 1ns;
timeprecision 10ps;

wire ACC ;
wire DivisorH ;
wire DivisorL ;
wire Result ;

// include netlist information from bitslice.vnet

`include "bitslice.vnet"

assign DivisorH = SHRoutDH;
assign DivisorL = SHRoutDL;
assign Result   = SHLoutResult;

endmodule
