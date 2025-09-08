4-bit Multi-Mode Counter
How it works

This project implements a 4-bit multi-mode counter that can operate in three modes:

Up Counter – counts from 0 → 15.

Down Counter – counts from 15 → 0.

Up/Down Toggle – counts up from 0 → 15, then reverses to count down to 0, and repeats.

The mode is selected using uio_in[1:0]:

00 → Up

01 → Down

10 → Up/Down toggle

The counter output is provided on uo_out[3:0], and unused outputs remain at 0. The design uses a clock input (clk) and an active-low reset (rst_n) to initialize the counter.

How to test

Connect a clock signal to clk (e.g., 1 MHz).

Drive rst_n low briefly to reset the counter, then set it high.

Select a counting mode using uio_in[1:0].

Observe the counter output on uo_out[3:0].

For visualization, you can connect LEDs to uo_out[3:0] to see the counting sequence.

External hardware

LEDs – to visualize the 4-bit counter output.

Optional: 7-segment display for decimal output using a simple 4-bit to 7-segment decoder.

Truth Tables
Mode: Up Counter (uio_in[1:0] = 00)
clk cycle	uo_out[3:0]
0	0000
1	0001
2	0010
3	0011
4	0100
…	…
15	1111
16	0000
Mode: Down Counter (uio_in[1:0] = 01)
clk cycle	uo_out[3:0]
0	1111
1	1110
2	1101
3	1100
4	1011
…	…
15	0000
16	1111
Mode: Up/Down Toggle (uio_in[1:0] = 10)
clk cycle	uo_out[3:0]
0	0000
1	0001
2	0010
3	0011
4	0100
…	…
15	1111
16	1110
17	1101
…	…
31	0000
32	0001

Note: In Up/Down mode, the counter reverses direction at 0 and 15.
