/*
 * Copyright (c) 2025 Shriyanka Priya Pradhan
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_multimode_counter (
    input  wire [7:0] ui_in,    // Not used in counter, can be ignored
    output wire [7:0] uo_out,   // Counter output (4-bit in lower nibble)
    input  wire [7:0] uio_in,   // Mode select input (use lower 2 bits)
    output wire [7:0] uio_out,  // Not used
    output wire [7:0] uio_oe,   // Not used
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // active low reset
);

  // Internal counter register
  reg [3:0] count;
  reg       dir; // direction for up/down toggle mode

  // Mode definitions (from uio_in[1:0])
  localparam MODE_UP      = 2'b00;
  localparam MODE_DOWN    = 2'b01;
  localparam MODE_UPDOWN  = 2'b10;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count <= 4'b0000;
      dir   <= 1'b1; // start counting up
    end else begin
      case (uio_in[1:0])
        MODE_UP: begin
          count <= count + 1;
        end
        MODE_DOWN: begin
          count <= count - 1;
        end
        MODE_UPDOWN: begin
          if (dir) begin
            count <= count + 1;
            if (count == 4'b1111) dir <= 0; // change direction at max
          end else begin
            count <= count - 1;
            if (count == 4'b0000) dir <= 1; // change direction at min
          end
        end
        default: begin
          count <= count; // hold
        end
      endcase
    end
  end

  // Assign counter output to uo_out (lower 4 bits)
  assign uo_out  = {4'b0000, count};
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Prevent warnings for unused inputs
  wire _unused = &{ui_in, ena};

endmodule
