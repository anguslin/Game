// Part 2 skeleton

module top(CLOCK_50, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, KEY,SW);
//VGA Outputs
output	VGA_CLK;   	// VGA Clock
output	VGA_HS;		// VGA H_SYNC
output	VGA_VS;		// VGA V_SYNC
output	VGA_BLANK_N;	// VGA BLANK
output	VGA_SYNC_N;	// VGA SYNC
output	[9:0]	VGA_R; 	// VGA Red[9:0]
output	[9:0]	VGA_G;	// VGA Green[9:0]
output	[9:0]	VGA_B; 	// VGA Blue[9:0]
//Other user inputs + clock 
input [5:0] SW;
input [3:0] KEY;
input CLOCK_50;	//50 MHz
//Wires
wire resetn = KEY[0];	 
wire go = key[1];

wire [2:0] player1Choice;
wire [2:0] player2Choice;

assign resetn = KEY[0];
assign clk = CLOCK_50;
assign player1Choice = SW[2:0]
assign player2Choice = SW[2:0]

`define cat 3'b001
`define dog 3'b010
`define chicken 3'b100

// Create an Instance of a VGA controller - there can be only one!
// Define the number of colours as well as the initial background
// image file (.MIF) for the controller.
vga_adapter VGA(.resetn(resetn), .clock(CLOCK_50), .colour(colour), .x(x), .y(y), .plot(Plt),
/* Signals for the DAC to drive the monitor. */
.VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_BLANK(VGA_BLANK_N),.VGA_SYNC(VGA_SYNC_N), .VGA_CLK(VGA_CLK));
defparam VGA.RESOLUTION = "160x120";
defparam VGA.MONOCHROME = "FALSE";
defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
defparam VGA.BACKGROUND_IMAGE = "black.mif";




endmodule



