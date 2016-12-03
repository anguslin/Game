//D Flip Flop
module DFlipFlop(clk, in, out, reset);
parameter n=1;
input clk, reset;
input [n-1:0] in;
output reg [n-1:0] out;
wire [n-1:0] outToUpdate;

assign outToUpdate = reset? 0: in;

//Update on rising edge
always @(posedge clk)
	out = outToUpdate;
endmodule

//D Flip Flop with Enable
module DFlipFlopEnable(clk, in, out, reset, enable);
parameter n = 1;
input clk, enable, reset;
input [n-1:0] in;
output reg [n-1:0] out;
wire [n-1:0] outToUpdate;

//If reset, set to 0, otherwise if enable is on, then set it as
assign outToUpdate = reset? 0:(enable? in: out);

//Update on rising edge
always @(posedge clk) 
	out = outToUpdate;
endmodule
