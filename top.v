// Part 2 skeleton

module top
(
	CLOCK_50,	// On Board 50 MHz
	// Your inputs and outputs here
	// The ports below are for the VGA output.  Do not change.
	VGA_CLK,   	// VGA Clock
	VGA_HS,		// VGA H_SYNC
	VGA_VS,		// VGA V_SYNC
	VGA_BLANK_N,	// VGA BLANK
	VGA_SYNC_N,	// VGA SYNC
	VGA_R,   	// VGA Red[9:0]
	VGA_G,	 	// VGA Green[9:0]
	VGA_B,   	// VGA Blue[9:0]
	KEY,
	SW
);

input [9:0] SW;
input [3:0] KEY;
input CLOCK_50;	//50 MHz
// Declare your inputs and outputs here
// Do not change the following outputs
output	VGA_CLK;   	// VGA Clock
output	VGA_HS;		// VGA H_SYNC
output	VGA_VS;		// VGA V_SYNC
output	VGA_BLANK_N;	// VGA BLANK
output	VGA_SYNC_N;	// VGA SYNC
output	[9:0]	VGA_R; 	// VGA Red[9:0]
output	[9:0]	VGA_G;	// VGA Green[9:0]
output	[9:0]	VGA_B; 	// VGA Blue[9:0]


// Create the colour, x, y and writeEn wires that are inputs to the controller.
wire resetn = KEY[0];	 
wire [3:0] colourin;

wire [25:0] count1;
wire [7:0] xCount;
wire [6:0] yCount;

wire [3:0] coordshift;
wire [2:0] colour;
wire [7:0] x;
wire [6:0] y;


datapath d1(


	.clk(CLOCK_50),
	.resetn(resetn),
	.xtog(xtog), .ytog(ytog),
	.colour_in(colourin),

	.coordshift(coordshift),
	.ld_X(ld_X), .ld_Y(ld_Y), .ld_CX(ld_CX), .ld_CY(ld_CY), .ld_black(ld_black),	 

	.colour(colour),
	.x(x),
	.y(y)
);

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

module controller(

	input clk,
	input resetn,
	input frametog,
	output reg [3:0] coordshift,
	output reg ld_X, ld_Y, Plt, ld_CX, ld_CY, ld_black


);

reg [5:0] current_state, next_state;



localparam  
S_WAIT				= 5'd0,
	S_CLEARSHIFT    	= 5'd5,
	S_CLEAR				= 5'd1,
	S_RELOCATE			= 5'd2,
	S_DRAWSHIFT    	= 5'd3,
	S_DRAW				= 5'd4;



// Next state logic aka our state table
always@(*)
begin: state_table 
case (current_state)
	S_WAIT:				next_state = frametog ? S_CLEARSHIFT : S_WAIT;

	S_CLEARSHIFT: 		next_state = S_CLEAR; // Loop in current state until value is input						

	S_CLEAR:		
		if (coordshift == 4'b1111)
		begin
			next_state = S_RELOCATE;													
		end
		else
			next_state = S_CLEARSHIFT;

		S_RELOCATE: 		next_state = S_DRAWSHIFT;

		S_DRAWSHIFT:		next_state = S_DRAW;

		S_DRAW:		
			if (coordshift == 4'b1111)
			begin
				next_state = S_WAIT;													
			end
			else
				next_state = S_DRAWSHIFT;						

			default:     next_state = S_WAIT;
		endcase
	end // state_table

	// Output logic aka all of our datapath control signals
	always @(*)
	begin: enable_signals
		// By default make all our signals 0
		ld_X = 1'b0; 
		ld_Y = 1'b0;  
		Plt = 1'b0; 
		ld_CX = 1'b0; 
		ld_CY = 1'b0;
		ld_black = 1'b0;

		case (current_state)
			S_CLEARSHIFT: begin
				ld_CX = 1'b1; 
				ld_CY = 1'b1;
				ld_black = 1'b1;					 
			end

			S_CLEAR: begin
				Plt = 1'b1;
				ld_black = 1'b1;
			end

			S_RELOCATE: begin
				ld_Y = 1'b1;
				ld_X = 1'b1;
			end

			S_DRAWSHIFT: begin
				ld_CX = 1'b1; 
				ld_CY = 1'b1;
			end

			S_DRAW:begin
				Plt = 1'b1;

			end

			S_WAIT:begin
				Plt = 1'b1;

			end

			// default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
			endcase
		end // enable_signals

		// current_state registers
		always@(posedge clk)
		begin: state_FFs
			if(!resetn)
				current_state <= S_WAIT;
			else
				current_state <= next_state;
		end // state_FFS

		endmodule

		module datapath(
			input clk,
			input resetn,
			input xtog, ytog,
			input [2:0] colour_in,

			input [3:0] coordshift,
			input ld_X, ld_Y, ld_CX, ld_CY, ld_black,	 

			output reg [2:0] colour,
			output reg [7:0] x,
			output reg [6:0] y
		);

		// input registers
		reg [7:0] x_in;
		reg [6:0] y_in;
		reg horiz, vert;

		// Registers A num den with respective input logic
		always@(posedge clk) begin
			case(resetn)
				0: begin
					x_in <= 7'b0; 
					y_in <= 6'b0;
					colour 	<= 0;
					x 			<= 0;
					y 			<= 0;
					horiz    <= 1;
					vert		<= 1;	
				end

				1: begin
					if(ld_X)
						x_in <= horiz ? (x_in+1) : (x_in-1) ; // horiz 1 = right
					if(ld_Y)
						y_in <= vert ? (y_in+1) : (y_in-1) ; // vert 1 = down
				end
				default: begin
					x_in <= 7'b0; 
					y_in <= 6'b0;
					colour 	<= 0;
					x 			<= 0;
					y 			<= 0;
					horiz    <= 1;
					vert		<= 1;	
				end
			endcase
			colour <= ld_black ? 3'b000 : colour_in;
			if (x_in == 156)
				horiz <= 0;
			if (x_in == 0)
				horiz <= 1;
			if (y_in == 116)
				vert <= 0;
			if (y_in == 0)
				vert <= 1;
		end

		endmodule





