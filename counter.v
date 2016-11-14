//Designed to delay signals that need to wait before turning to 1
module delaySignal (clk, reset, signal); //delays signal so it goes at 4Hz
input clk, reset;
output signal;

counter26Bit c1(clk,  reset, count); // counts up at 50MHz
hz4 h1(count, signal); //signal is set to 1 when it counts to 4hz

endmodule

//Counts up
module counter26Bit (clk, reset,  count); // counts up at 25MHz
input clk, reset;
output reg [25:0] count;

assign countToUpdate = reset? 1'b0:(count+1);

always @(posedge clk) // triggered every time clock rises	
	count = countToUpdate;

endmodule

//Checks when counter finishes counting
module hz4 (count, countReady); //div = 1 when it counts to designated value
input [25:0] count;
output countReady;

assign countReady = (count == 26'd12500000) ? 1'b1 : 1'b0;

endmodule


