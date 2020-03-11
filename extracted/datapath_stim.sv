//////////////////////////////////////////////////////////////////
// File: datapath_stim.sv
//   Stimulus for datapath.sv, part of 8-bit Divider Type 2, VLSI Coursework.
// Last Modified: 10/11/2018
// Author: Samyuel Danyo
/////////////////////////////////////////////////////////////////

// ----------- Module ----------
module datapath_stim;

  // ----------- Timing ----------
timeunit 1ns; timeprecision 10ps;

  // ----------- Signals ---------
  logic Clock ;
  logic Load ;
  logic LoadAcc ;
  logic LoadResult ;
  logic nBorrowIn ;
  logic nReset ;
  logic nZIn ;
  logic [7:0] Operand1 ;
  logic [7:0] Operand2 ;
  logic SDI ;
  logic ShiftIn ;
  logic ShiftInDH ;
  logic Test ;

  wire nBorrow ;
  wire nZ ;
  wire [7:0] Quotient ;
  wire [7:0] Remainder ;
  wire SDO ;
  wire [7:0] ACC ;
  wire [7:0] DivisorH;
  wire [7:0] DivisorL;
  wire [7:0] Result;

  // ----------- Constants & Parameters ----------
  parameter Clock_period = 100;

  // ----------- DUT ----------
  datapath instance1(
	.nBorrow,
	.nZ,
	.Quotient,
	.Remainder,
	.SDO,
	.Clock,
	.Load,
	.LoadAcc,
	.LoadResult,
	.nBorrowIn,
	.nReset,
	.nZIn,
	.Operand1,
	.Operand2,
	.SDI,
	.ShiftIn,
	.ShiftInDH,
	.Test
	);

  assign ACC = instance1.ACC;
  assign DivisorH = instance1.DivisorH;
  assign DivisorL = instance1.DivisorL;
  assign Result = instance1.Result;

  // ----------- Clock ----------
  initial
      Clock = 0;
  always
    #(Clock_period/2)
      Clock = ~Clock;

  // ----------- Reset ----------
  initial
    begin
        nReset = 1;
      #(Clock_period*2)
        nReset = 0;
      #(Clock_period*2)
        nReset = 1;
    end

  // ----------- Test ----------
  initial
    begin
        Load = 1;
        LoadAcc = 1;
        LoadResult = 1;
        nBorrowIn = 1;
        nZIn = 0;
        Operand1 = 9;
        Operand2 = 8;
        SDI = 0;
        ShiftIn = 0;
        ShiftInDH = 0;
        Test = 0;
      #(Clock_period*5);
        Load = 0;
        LoadAcc = 0;
        ShiftIn = 0;
      #(Clock_period*8);
        LoadAcc = 1;
        ShiftIn = 1;
      #(Clock_period*1);
        Load = 1;
        ShiftIn = 0;
      #(Clock_period*3)
          $stop;
          $finish;
  end

  // ----------- Feedback ----------
  initial
    $monitor($time,
    ,"%b", Clock ,
    ,"%b", Load ,
    ,"%b", LoadAcc ,
    ,"%b", LoadResult ,
    ,"%b", nBorrowIn ,
    ,"%b", nReset ,
    ,"%b", nZIn ,
    ,"%b", Operand1 ,
    ,"%b", Operand2 ,
    ,"%b", SDI ,
    ,"%b", ShiftIn ,
    ,"%b", ShiftInDH , 
    ,"%b", Test ,
    ,"%b", nBorrow ,
    ,"%b", nZ ,
    ,"%b", Quotient ,
    ,"%b", Remainder ,
    ,"%b", SDO ,
    );

//SIMVISION SCRIPT:datapath.tcl

endmodule
