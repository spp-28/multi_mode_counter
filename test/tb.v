`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Clock generation (left unconnected / can be driven externally)
  // initial clk = 0;
  // always #5 clk = ~clk;

  // Instantiate the multi-mode counter
  tt_um_multimode_counter uut (
      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

endmodule
