//////////////////////////////////////////////////////////////////
// File: bitslice_stim.sv
//   Stimulus for bitslice.sv, part of 8-bit Divider Type 2, VLSI Coursework.
// Last Modified: 10/11/2018
// Author: Samyuel Danyo
/////////////////////////////////////////////////////////////////

// ----------- Module ----------
module bitslice_stim;

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
  logic Operand1 ;
  logic Operand2 ;
  logic SDI ;
  logic SHLinResult ;
  logic SHRinDH ;
  logic SHRinDL ;
  logic Test ;

  wire nBorrowOut ;
  wire nZOut ;
  wire Quotient ;
  wire Remainder ;
  wire SDO ;
  wire SHLoutResult ;
  wire SHRoutDH ;
  wire SHRoutDL ;
  wire Result ;
  wire DivisorH ;
  wire DivisorL ;
  wire ACC ;

  // ----------- Constants & Parameters ----------
  parameter Clock_period = 100;

  // ----------- DUT ----------
  bitslice instance1(
	.nBorrowOut,
	.nZOut,
	.Quotient,
	.Remainder,
	.SDO,
	.SHLoutResult,
	.SHRoutDH,
	.SHRoutDL,     
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
	.SHLinResult,
	.SHRinDH,
	.SHRinDL,
	.Test
	); 

  assign ACC = instance1.ACC;
  assign DivisorH = instance1.DivisorH;
  assign DivisorL = instance1.DivisorL;
  assign Result   = instance1.Result;

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
        LoadResult = 0;
        nBorrowIn = 1;
        nZIn = 0;
        Operand1 = 0;
        Operand2 = 1;
        SDI = 0;
        SHLinResult = 1;
        SHRinDH = 0;
        SHRinDL = 1;
        Test = 0;
      #(Clock_period*5)
        LoadResult = 1;
      #(Clock_period*1)  
        Load = 0;
      #(Clock_period*3);
        LoadAcc = 0;
      #(Clock_period*1);
        Operand1 = 1;
      #(Clock_period*1);
        Load = 1;
      #(Clock_period*1);
        LoadAcc = 1;
      #(Clock_period*3);
        Operand2 = 0;
      #(Clock_period*3);
        Operand1 = 0;
      #(Clock_period*4);
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
    ,"%b", SHLinResult ,
    ,"%b", SHRinDH ,
    ,"%b", SHRinDL ,
    ,"%b", Test ,
    ,"%b", nBorrowOut ,
    ,"%b", nZOut ,
    ,"%b", Quotient ,
    ,"%b", Remainder ,
    ,"%b", SDO ,
    ,"%b", Result ,
    ,"%b", DivisorH ,
    ,"%b", DivisorL ,
    ,"%b", ACC ,
    );

//SIMVISION SCRIPT:bitslice.tcl

endmodule
