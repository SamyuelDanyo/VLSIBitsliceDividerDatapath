// structural model of control extracted from control.mag
// created by ext2svmod 8.0

module control(
	output Done ,
	output Load ,
	output LoadAcc ,
	output LoadResult ,
	output SDO ,
	output ShiftIn ,
	input Clock ,
	input nBorrow ,
	input nReset ,
	input nZ ,
	input Req ,
	input SDI ,
	input Test 
	);

timeunit 1ns;
timeprecision 10ps;



// include netlist information from control.vnet

`include "../extracted/control.vnet"

endmodule
