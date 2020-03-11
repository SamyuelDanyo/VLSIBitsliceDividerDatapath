//////////////////////////////////////////////////////////////////
// File: control_stim.sv
//   Stimulus for control.sv, part of 8-bit Divider Type 2, VLSI Coursework.
// Last Modified: 10/11/2018
// Author: Samyuel Danyo
/////////////////////////////////////////////////////////////////

// ----------- Module ----------
module control_stim;

  // ----------- Timing ----------
  timeunit 1ns; timeprecision 10ps;

  // ----------- Signals ---------
  logic Clock ;
  logic nBorrow ;
  logic nReset ;
  logic nZ ;
  logic Req ;
  logic SDI ;
  logic Test ;

  wire Load ;
  wire LoadAcc ;
  wire LoadResult ;
  wire ShiftIn ;
  wire Done ;
  wire SDO ;

  // ----------- Constants & Parameters ----------
  parameter Clock_period = 100;

  // ----------- DUT ----------
  control instance1(
        .Done ,
        .Load ,
        .LoadAcc ,
        .LoadResult ,
        .SDO ,
        .ShiftIn ,
        .Clock ,
        .nBorrow ,
        .nReset ,
        .nZ ,
        .Req ,
        .SDI ,
        .Test 
        );

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
        Test = 0;
        SDI = 1;
        nBorrow = 1;
        nZ = 1;
        Req = 0;
      #(Clock_period*5);
        Req = 1;
      #(Clock_period*4);
        nBorrow = 0;
        nZ = 0;
      #(Clock_period*4); 
        nBorrow = 1;
      #(Clock_period*1);
        nBorrow = 0;
      #(Clock_period*1);
        nBorrow = 1;
        nZ = 1;
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
    ,"%b", nReset ,
    ,"%b", ShiftIn ,
    ,"%b", nBorrow ,
    ,"%b", nZ ,
    );


//SIMVISION SCRIPT:control.tcl

endmodule
