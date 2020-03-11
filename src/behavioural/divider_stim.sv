//////////////////////////////////////////////////////////////////
// File: divider_stim.sv
//   Stimulus for divider.sv, part of 8-bit Divider Type 2, VLSI Coursework.
// Last Modified: 10/11/2018
// Author: Samyuel Danyo
/////////////////////////////////////////////////////////////////

// ----------- Module ----------
module divider_stim;

  // ----------- Timing ----------
  timeunit 1ns; timeprecision 10ps;

  // ----------- Signals ---------
  logic       Clock ;
  logic       nReset ;
  logic       Req ;
  logic [7:0] Operand1 ;
  logic [7:0] Operand2 ;
  
  wire [7:0] Quotient ;
  wire [7:0] Remainder ;
  wire       Done ;

  // ----------- Constants & Parameters ----------
  parameter Clock_period = 100;

  // ----------- DUT ----------
  divider instance1(
	.Clock,
	.nReset,
	.Req,
	.Operand1,
	.Operand2,
	.Done,
	.Quotient,
	.Remainder
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
      #(Clock_period*1)
        nReset = 0;
      #(Clock_period*2)
        nReset = 1;
    end

  // ----------- Randomised Test ----------
  initial
    begin
        Req = 0;
	Operand1 = 9;
	Operand2 = 8;
    end
  always
    begin
      #(Clock_period*4)
        assert(std::randomize(Req));
      #(Clock_period*1)
        Req = 0;
      #(Clock_period*5)
        assert(std::randomize(Operand1));
        assert(std::randomize(Operand2));
    end 
 
  // ----------- Feedback ----------
  always
    #(Clock_period*1)
      $strobe("STROBE  time:%5.1f Req:%d Operand1:%d Operand2:%d Done:%d Quotient:%d Remainder:%d",
		       $realtime, Req, Operand1, Operand2, Done, Quotient, Remainder);
      
  initial
   begin
     $display ("@time  Req Operand1 Operand2 Done Quotient Remainder");
     $monitor ("%5.1f %d   %d      %d      %d   %d      %d",
                $realtime, Req, Operand1, Operand2, Done, Quotient, Remainder);
     #(Clock_period*105)
       $stop;
  end


//SIMVISION SCRIPT:divider.tcl

endmodule
