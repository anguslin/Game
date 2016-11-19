
input clk, countReset, spriteCountReset, screenCountReset, xStart, yStart,



//Designed to delay signals that need to wait before turning to 1
module delaySignal (clk, reset, signal); //delays signal so it goes at 4Hz

//Screen Address Counters
module addressScreenCounter(clk, reset, screenCount); //15 bit address for the screens (120x160) = 19200 -> 2^15 = 32768

//Sprite Address Counters
module addressSpriteCounter(clk, reset, spriteCount); //11 bit address for the sprites (40x40) = 1600 -> 2^11 = 2048

module xInitReg (clk, reset, xInitSel, xInit, xInitLoad);
//The starting point of the ycoordinate
module yInitReg (clk, reset, yInitSel, yInit, yInitLoad);

module xReg(clk, reset, xSel, x, xLoad, xStart, countUp, xInit);

module yReg(clk, reset, ySel, y, yLoad, yStart, countUp, yInit);

//10 from title screens, 4 from chicken, 6 from dog, 12 from cat -> 10+4+6+12=32
module colour (clk, black, memorySel, title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, chickenLeft1, chickenLeft2, chickenRight1, chickenRight2, dogLeft1, dogLeft2, dogLeft3, dogRight1, dogRight2, dogRight3, catLeft1, catLeft2, catLeft3, catLeft4, catLeft5, catLeft6, catRight1, catRight2, catRight3, catRight4, catRight5, catRight6,  color);

module currentPlayerPoints(clk, reset, winner1, winner2, player1, player2, playerLoad)

