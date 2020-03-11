//////////////////////////////////////////////////////////////////
// File: control.sv
//   Behavioral model of a n-bit Divider Type 2, VLSI Coursework.
//     - Asynchronous reset, 9th clock cycle for result.
// Last Modified: 09/11/2018
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
module control #( parameter    OPERAND_W = 8) (
                  input        Clock, nReset, Req, nZ, nBorrow,
                  output logic Done, Load, LoadAcc, LoadResult, ShiftIn );

  // ----------- Timing ----------
  timeunit 1ns; timeprecision 10ps;

  // ----------- Internal Variables ----------
  logic [(`CLOG2(OPERAND_W))-1:0] cnt;

  // ----------- State Declaration ----------
  enum logic [1:0] { SETUP, DIVIDE, RESULT, EMPTY} state;

  // ----------- State + Next State Logic ----------
  always_ff @( posedge Clock, negedge nReset )
    if (!nReset) begin
      cnt   <= 0;
      state <= SETUP;
    end
    else
      case (state)
        SETUP : begin
          cnt <= #20 0;
	  if (Req)
	    state <= #20 DIVIDE;
	  else
            state <= #20 SETUP;
        end //SETUP
        DIVIDE : begin
	  if (cnt == OPERAND_W-1)
	    state <= #20 RESULT;
	  else begin
            cnt   <= #20 cnt+1;
	    state <= #20 DIVIDE;
	  end
        end //DIVIDE
	RESULT : 
          if (cnt == OPERAND_W-1) begin
            cnt   <= #20 0;
            state <= #20 RESULT;
          end
          else begin
            cnt   <= #20 OPERAND_W-1;
	    state <= #20 SETUP;
          end
	EMPTY :
	  state <= #20 SETUP;
      endcase

  // ------------- Output Logic -------------
  assign Done = ((state == SETUP) && (cnt == OPERAND_W-1))? 1 : 0;
  assign Load = /*(((state == SETUP) && Req) ||*/ (state == DIVIDE || state == RESULT)? 0 : 1;
  assign LoadAcc = ((state == DIVIDE || state == RESULT) && (nZ || !nBorrow))? 0 : 1;
  assign LoadResult = ((state == RESULT) && !cnt)? 1 : 0;
  assign ShiftIn = ((state == DIVIDE || state == RESULT) & !nZ && nBorrow)? 1 : 0;
  
endmodule
