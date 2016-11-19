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
wire [25:0] countToUpdate;

assign countToUpdate = reset? 26'b0:(count+1);

always @(posedge clk) // triggered every time clock rises	
	count = countToUpdate;
endmodule

//Checks when counter finishes counting
module hz4 (count, countReady); //div = 1 when it counts to designated value
input [25:0] count;
output countReady;

assign countReady = (count == 26'd12500000) ? 1'b1 : 1'b0;

endmodule

//Screen Address Counters
module addressScreenCounter(clk, reset, screenCount); //15 bit address for the screens (120x160) = 19200 -> 2^15 = 32768
input clk, reset;
output reg [14:0] screenCount;
wire [14:0] screenCountToUpdate;

assign screenCountToUpdate = reset? 15'b0: (screenCount + 1)

always @(posedge clk)
	screenCount = screenCountToUpdate;
endmodule

//Sprite Address Counters
module addressSpriteCounter(clk, reset, spriteCount); //11 bit address for the sprites (40x40) = 1600 -> 2^11 = 2048
input clk, reset;
output reg [10:0] spriteCount;
wire [10:0] spriteCountToUpdate;

assign spriteCountToUpdate = reset? 11'b0: (spriteCount + 1)

always @(posedge clk)
	spriteCount = spriteCountToUpdate;
endmodule

