module datapath(clk, xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, xySel, black, playerReset,winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad, yInitSel, xInitSel, memorySel, x, y, color, player1, player2);

input clk, xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, black, playerReset, winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad; 
input [1:0] yInitSel, xySel;
input [3:0] xInitSel;
input [4:0] memorySel;

//VGA outputs
output [7:0] x; 
output [6:0] y;
output [2:0] color;
//Display player points on LEDs
output [3:0] player1, player2;

wire [6:0] yInit;
wire [7:0] xInit;
wire [14:0] screenCount;
wire [10:0] spriteCount;

//Color outputs from the memory ROMs
wire [2:0] title1Color, title2Color, title3Color, choose1Color, choose2Color, choose3Color, p1Win1Color, p1Win2Color, p2Win1Color, p2Win2Color, chickenLeft1Color, chickenLeft2Color, chickenRight1Color, chickenRight2Color, dogLeft1Color, dogLeft2Color, dogLeft3Color, dogRight1Color, dogRight2Color, dogRight3Color, catLeft1Color, catLeft2Color, catLeft3Color, catLeft4Color, catLeft5Color, catLeft6Color, catRight1Color, catRight2Color, catRight3Color, catRight4Color, catRight5Color, catRight6Color;

//Module Instantiations

//Memory ROMs
Title1 Title1Mem(.address(screenCount), .clock(clk), .q(title1Color));
//The starting point of the x coordinate
xInitReg xInitial(.clk(clk), .xInitReset(xInitReset), .xInitSel(xInitSel), .xInit(xInit), .xInitLoad(xInitLoad));
//The starting point of the y coordinate
yInitReg yInital(.clk(clk), .yInitReset(yInitReset), .yInitSel(yInitSel), .yInit(yInit), .yInitLoad(yInitLoad));
//Choose x and y coordinates to output to VGA
xyReg xyRegiser(.clk(clk), .xReset(xReset), .yReset(yReset), .xySel(xySel), .x(x), .y(y), .xLoad(xLoad), .yLoad(yLoad), .xCountUp(xCountUp), .yCountUp(yCountUp), .xInit(xInit), .yInit(yInit));
//Choose Color to be output to VGA based on memory
color colorReg(.clk(clk), .black(black), .memorySel(memorySel), .title1(title1Color), .title2(title2Color), .title3(title3Color), .choose1(choose1Color), .choose2(choose2Color), .choose3(choose3Color), .p1Win1(p1Win1Color), .p1Win2(p1Win2Color), .p2Win1(p2Win1Color), .p2Win2(p2Win2Color), .chickenLeft1(chickenLeft1Color), .chickenLeft2(chickenLeft2Color), .chickenRight1(chickenRight1Color), .chickenRight2(chickenRight2Color), .dogLeft1(dogLeft1Color), .dogLeft2(dogLeft2Color), .dogLeft3(dogLeft3Color), .dogRight1(dogRight1Color), .dogRight2(dogRight2Color), .dogRight3(dogRight3Color), .catLeft1(catLeft1Color), .catLeft2(catLeft2Color), .catLeft3(catLeft3Color), .catLeft4(catLeft4Color), .catLeft5(catLeft5Color), .catLeft6(catLeft6Color), .catRight1(catRight1Color), .catRight2(catRight2Color), .catRight3(catRight3Color), .catRight4(catRight4Color), .catRight5(catRight5Color), .catRight6(catRight6Color), .color(color));
//Current Player Points 
currentPlayerPoints pointsRegister(.clk(clk), .playerReset(playerReset), .winner1(winner1), .winner2(winner2), .player1(player1), .player2(player2), .playerLoad(playerLoad));
//Screen Address Counters
addressScreenCounter screenCounter(.clk(clk), .addressScreenCounterReset(addressScreenCounterReset), .screenCount(screenCount), .screenCountLoad(screenCountLoad)); 
//Sprite Address Counters
addressSpriteCounter spriteCounter(.clk(clk), .addressSpriteCounterReset(addressSpriteCounterReset), .spriteCount(spriteCount), .spriteCountLoad(spriteCountLoad)); //11 bit address for the sprites (40x40) = 1600 -> 2^11 = 2048

endmodule
