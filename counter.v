
//Designed to delay signals that need to wait before turning to 1
module delaySignal (clk, delaySignalReset, signal); //delays signal so it goes at 4Hz
input clk, delaySignalReset;
output signal;
wire [25:0] count;
wire doneCount;

assign signal = doneCount;

counter26Bit c1(clk, delaySignalReset, doneCount, count); // counts up at 50MHz
hz4 h1(count, doneCount); //signal is set to 1 when it counts to 4hz
endmodule

//Counts up
module counter26Bit (clk, counterReset, doneCount, count); // counts up at 25MHz
input clk, counterReset, doneCount;
output reg [25:0] count;
wire [25:0] countToUpdate;

assign countToUpdate = counterReset? 26'b0: (doneCount?: 26'b0: (count+1)); //Resets back to 0 and keeps counting until next delay
DFlipFlop #(26) counter26BitReg(clk, countToUpdate, count, counterReset);
endmodule

//Checks when counter finishes counting
module hz4 (count, doneCount); //div = 1 when it counts to designated value
input [25:0] count;
output doneCount;

assign doneCount = (count == 26'd12500000) ? 1'b1 : 1'b0;
endmodule

//Screen Address Counters
module addressScreenCounter(clk, addressScreenCounterReset, screenCount, screenCountLoad); //15 bit address for the screens (120x160) = 19200 -> 2^15 = 32768
input clk, addressScreenCounterReset, screenCountLoad;
output reg [14:0] screenCount;
wire [14:0] screenCountToUpdate;

assign screenCountToUpdate =  screenCount + 1;
DFlipFlopEnable #(15) screenCountReg(clk, screenCountToUpdate, screenCount, addressScreenCounterReset, screenCountLoad);
endmodule

//Sprite Address Counters
module addressSpriteCounter(clk, addressSpriteCounterReset, spriteCount, spriteCountLoad); //11 bit address for the sprites (40x40) = 1600 -> 2^11 = 2048
input clk, addressSpriteCounterReset, spriteCountLoad;
output reg [10:0] spriteCount;
wire [10:0] spriteCountToUpdate;

assign spriteCountToUpdate =  spriteCount + 1;
DFlipFlopEnable #(11) spriteCountReg(clk, spriteCountToUpdate, spriteCount, addressSpriteCounterReset, spriteCountLoad);
endmodule

