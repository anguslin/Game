
module blackScreen(clock, reset, dataIn, xEnable, yEnable, colourEnable, x, y, colour, controlReset, countUp);
	input [9:0] dataIn;
	input clock, reset;
	input xEnable, yEnable, colourEnable;
	input controlReset, countUp;
	
	reg [7:0] x_in;
	reg [6:0] y_in;
	output reg [2:0] colour;
	
	output reg [7:0] x;
	output reg [7:0] y;
	
	always @(posedge clock) begin
		if (reset | controlReset) 
			xIn <= 8'b0;
			yIn <= 7'b0;	
			colour <= 3'b0;
	 else begin
			if (xEnable)
				xIn <= {1'b0, dataIn[6:0]};
			if (yEnable)
				yIn <= dataIn[6:0];
			if (colourEnable)
				colour <= dataIn[9:7];
				if (x_in < 160 & y_in == 120) begin
					x_in <= x_in + 1;
					y_in <= 0;
				end if (y < 120)
					y_in <= y_in + 1;
			end
		end
	end	
endmodule 


