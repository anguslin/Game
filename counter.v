
//Designed to delay signals that need to wait before turning to 1
module delaySignal (clk, delaySignalReset, signal); //delays signal so it goes at 4Hz
input clk, delaySignalReset;
output signal;
reg [25:0] count;

assign signal = (count == 26'd12500000) ? 1'b1 : 1'b0;

always @(posedge clk) // triggered every time clock rises	
	begin
		if(delaySignalReset == 1)
			count = 0;
		else 
			count = count +1;
	end
endmodule

//Screen Address Counters
module addressScreenCounter(clk, addressScreenCounterReset, screenCount, screenCountLoad); //15 bit address for the screens (120x160) = 19200 -> 2^15 = 32768
input clk, addressScreenCounterReset, screenCountLoad;
output [14:0] screenCount;
wire [14:0] screenCountToUpdate;

assign screenCountToUpdate =  screenCount + 1;
DFlipFlopEnable #(15) screenCountReg(clk, screenCountToUpdate, screenCount, addressScreenCounterReset, screenCountLoad);
endmodule

//Sprite Address Counters
//module addressSpriteCounter(clk, addressSpriteCounterReset, spriteCount, spriteCountLoad); //11 bit address for the sprites (40x40) = 1600 -> 2^11 = 2048
//input clk, addressSpriteCounterReset, spriteCountLoad;
//output [10:0] spriteCount;
//wire [10:0] spriteCountToUpdate;

//assign spriteCountToUpdate =  spriteCount + 1;
//DFlipFlopEnable #(11) spriteCountReg(clk, spriteCountToUpdate, spriteCount, addressSpriteCounterReset, spriteCountLoad);
//endmodule
