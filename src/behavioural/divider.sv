//////////////////////////////////////////////////////////////////
// File: divider.sv
//   Top-level of a 8-bit Divider Type 2, VLSI Coursework.
//     - Asynchronous reset, Req for new division
//     - Done on 10th clock cycle for result.
// Last Modified: 10/11/2018
// Author: Samyuel Danyo
/////////////////////////////////////////////////////////////////

// ----------- Defines ----------
`define CLOG2(x)   \
   (x <= 2) ? 1 :  \
   (x <= 4) ? 2 :  \
   (x <= 8) ? 3 :  \
   (x <= 16) ? 4 : \
   (x <= 32) ? 5 : \
   (x <= 64) ? 6 : \
   -1

// ----------- Module ----------
module divider #( parameter    OPERAND_W = 8) (
                  output wire [OPERAND_W-1:0] Quotient, Remainder,
                  output wire                 Done, 
                  input       [OPERAND_W-1:0] Operand1, Operand2,
                  input                       Req, Clock, nReset );

  // ----------- Timing ----------
  timeunit 1ns; timeprecision 10ps;

  // ----------- Internal Variables ----------
  logic nBorrowIn = 1;
  logic nZIn      = 0;
  logic ShiftInDH = 0;

  logic Test      = 0;
  logic SDI       = 0;

  wire Load ;
  wire LoadAcc ;
  wire LoadResult ;
  wire ShiftIn ;

  wire nBorrow ;
  wire nZ ;

  wire SDO ;

  // ----------- Structure ----------
  control #(.OPERAND_W(OPERAND_W)) control  ( .nBorrow, .nZ, .Clock, .Load,
                                              .LoadAcc, .LoadResult, .nReset,
                                              .ShiftIn, .Req, .Done );

  datapath                         datapath ( .nBorrow, .nZ, .Quotient, .Remainder,
                                              .Clock, .Load, .LoadAcc,
                                              .LoadResult, .nBorrowIn, .nReset, .nZIn,
                                              .Operand1, .Operand2, .ShiftIn,
                                              .ShiftInDH, .Test, .SDI, .SDO );

endmodule
