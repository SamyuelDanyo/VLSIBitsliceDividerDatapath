#////////////////////////////////////////////////////////////////
# File: divider.tcl
#   SimVision command script for divider, part of 8-bit Divider Type 2, VLSI Coursework.
# Last Modified: 10/11/2018
# Author: Samyuel Danyo
#///////////////////////////////////////////////////////////////

database -open waves
probe -all -depth all -database waves
run

simvision {

# List of signals to monitor defined here
#
set wave_signal_list {
  divider_stim.Clock
  divider_stim.nReset
  divider_stim.Req
  divider_stim.Operand1
  divider_stim.Operand2
  divider_stim.Done
  divider_stim.Quotient
  divider_stim.Remainder
  divider_stim.instance1.Load
  divider_stim.instance1.LoadAcc
  divider_stim.instance1.LoadResult
  divider_stim.instance1.ShiftIn
  divider_stim.instance1.nBorrow
  divider_stim.instance1.nZ
  divider_stim.instance1.datapath.DivisorH
  divider_stim.instance1.datapath.DivisorL
  divider_stim.instance1.datapath.ACC
  divider_stim.instance1.datapath.Result
}

# View Results
#
window new WaveWindow -name "Waves for divider"
waveform add -using "Waves for divider" -signals $wave_signal_list
waveform format -radix %d
waveform xview zoom -using "Waves for divider" -outfull

}

