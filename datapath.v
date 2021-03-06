module datapath(clk, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, xySel, black, playerReset,winner1, winner2, addressScreenCounterReset, screenCountLoad, memorySel, x, y, color, player1, player2);

input clk, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, black, playerReset, winner1, winner2, addressScreenCounterReset, screenCountLoad; 
input [1:0] xySel;
input [6:0] memorySel;

//VGA outputs
output [7:0] x; 
output [6:0] y;
output [2:0] color;
//Display player points on LEDs
output [3:0] player1, player2;

wire [14:0] screenCount;

//Color outputs from the memory ROMs
wire [2:0] title1Color, title2Color, title3Color, choose1Color, choose2Color, choose3Color, p1Win1Color, p1Win2Color, p2Win1Color, p2Win2Color, catCat2Color, catCat3Color, catChicken5Color, catChicken6Color, catChicken7Color, catChicken8Color, catChicken9Color, catDog5Color, catDog6Color, catDog7Color, catDog8Color, catDog9Color, dogDog2Color, dogDog3Color, dogCat5Color, dogCat6Color, dogCat7Color, dogCat8Color, dogCat9Color, dogChicken5Color, dogChicken6Color, dogChicken7Color, dogChicken8Color, dogChicken9Color, chickenChicken2Color, chickenChicken3Color, chickenDog5Color, chickenDog6Color, chickenDog7Color, chickenDog8Color, chickenDog9Color, chickenCat5Color, chickenCat6Color, chickenCat7Color, chickenCat8Color, chickenCat9Color;

//Memory ROMs
//Title
Title1 Title1Mem(.address(screenCount), .clock(clk), .q(title1Color));
Title2 Title2Mem(.address(screenCount), .clock(clk), .q(title2Color));
Title3 Title3Mem(.address(screenCount), .clock(clk), .q(title3Color));
//Choose Screens
Choose1 Choose1Mem(.address(screenCount), .clock(clk), .q(choose1Color));
Choose2 Choose2Mem(.address(screenCount), .clock(clk), .q(choose2Color));
Choose3 Choose3Mem(.address(screenCount), .clock(clk), .q(choose3Color));
//Player 1 Wins Screens
P1W P1WMem(.address(screenCount), .clock(clk), .q(p1Win1Color));
P1W2 P1W2Mem(.address(screenCount), .clock(clk), .q(p1Win2Color));
//Player 2 Wins Screens
P2W P2WMem(.address(screenCount), .clock(clk), .q(p2Win1Color));
P2W2 P2W2Mem(.address(screenCount), .clock(clk), .q(p2Win2Color));
//Cat Cat Screens
catCat2 catCat2Mem(.address(screenCount), .clock(clk), .q(catCat2Color));
catCat3 catCat3Mem(.address(screenCount), .clock(clk), .q(catCat3Color));
//Cat Dog Screens
catDog5 catDog5Mem(.address(screenCount), .clock(clk), .q(catDog5Color));
catDog6 catDog6Mem(.address(screenCount), .clock(clk), .q(catDog6Color));
catDog7 catDog7Mem(.address(screenCount), .clock(clk), .q(catDog7Color));
catDog8 catDog8Mem(.address(screenCount), .clock(clk), .q(catDog8Color));
catDog9 catDog9Mem(.address(screenCount), .clock(clk), .q(catDog9Color));
//Cat Chicken Screens
catChicken5 catChicken5Mem(.address(screenCount), .clock(clk), .q(catChicken5Color));
catChicken6 catChicken6Mem(.address(screenCount), .clock(clk), .q(catChicken6Color));
catChicken7 catChicken7Mem(.address(screenCount), .clock(clk), .q(catChicken7Color));
catChicken8 catChicken8Mem(.address(screenCount), .clock(clk), .q(catChicken8Color));
catChicken9 catChicken9Mem(.address(screenCount), .clock(clk), .q(catChicken9Color));
//Chicken Cat Screens
chickenCat5 ChickenCat5Mem(.address(screenCount), .clock(clk), .q(chickenCat5Color));
chickenCat6 ChickenCat6Mem(.address(screenCount), .clock(clk), .q(chickenCat6Color));
chickenCat7 ChickenCat7Mem(.address(screenCount), .clock(clk), .q(chickenCat7Color));
chickenCat8 ChickenCat8Mem(.address(screenCount), .clock(clk), .q(chickenCat18olor));
chickenCat9 ChickenCat9Mem(.address(screenCount), .clock(clk), .q(chickenCat9Color));
//Chicken Chicken Screens
chickenChicken2 ChickenChicken2Mem(.address(screenCount), .clock(clk), .q(chickenChicken2Color));
chickenChicken3 ChickenChicken3Mem(.address(screenCount), .clock(clk), .q(chickenChicken3Color));
//Chicken Dog Screens
chickenDog5 ChickenDog5Mem(.address(screenCount), .clock(clk), .q(chickenDog5Color));
chickenDog6 ChickenDog6Mem(.address(screenCount), .clock(clk), .q(chickenDog6Color));
chickenDog7 ChickenDog7Mem(.address(screenCount), .clock(clk), .q(chickenDog7Color));
chickenDog8 ChickenDog8Mem(.address(screenCount), .clock(clk), .q(chickenDog8Color));
chickenDog9 ChickenDog9Mem(.address(screenCount), .clock(clk), .q(chickenDog9Color));
//Dog Cat Screens
dogCat5 dogCat5Mem(.address(screenCount), .clock(clk), .q(dogCat5Color));
dogCat6 dogCat6Mem(.address(screenCount), .clock(clk), .q(dogCat6Color));
dogCat7 dogCat7Mem(.address(screenCount), .clock(clk), .q(dogCat7Color));
dogCat8 dogCat8Mem(.address(screenCount), .clock(clk), .q(dogCat8Color));
dogCat9 dogCat9Mem(.address(screenCount), .clock(clk), .q(dogCat9Color));
//Dog Chicken Screens
dogChicken5 dogChicken5Mem(.address(screenCount), .clock(clk), .q(dogChicken5Color));
dogChicken6 dogChicken6Mem(.address(screenCount), .clock(clk), .q(dogChicken6Color));
dogChicken7 dogChicken7Mem(.address(screenCount), .clock(clk), .q(dogChicken7Color));
dogChicken8 dogChicken8Mem(.address(screenCount), .clock(clk), .q(dogChicken8Color));
dogChicken9 dogChicken9Mem(.address(screenCount), .clock(clk), .q(dogChicken9Color));
//Dog Dog Screens
dogDog2 dogDog2Mem(.address(screenCount), .clock(clk), .q(dogDog2Color));
dogDog3 dogDog3Mem(.address(screenCount), .clock(clk), .q(dogDog3Color));

//Choose x and y coordinates to output to VGA
xyReg xyRegiser(.clk(clk), .xReset(xReset), .yReset(yReset), .xySel(xySel), .x(x), .y(y), .xLoad(xLoad), .yLoad(yLoad), .xCountUp(xCountUp), .yCountUp(yCountUp));
//Choose Color to be output to VGA based on memory
color colorReg(.clk(clk), .black(black), .memorySel(memorySel), .title1(title1Color), .title2(title2Color), .title3(title3Color), .choose1(choose1Color), .choose2(choose2Color), .choose3(choose3Color), .p1Win1(p1Win1Color), .p1Win2(p1Win2Color), .p2Win1(p2Win1Color), .p2Win2(p2Win2Color), .catCat2(catCat2Color), .catCat3(catCat3Color), .catChicken5(catChicken5Color), .catChicken6(catChicken6Color), .catChicken7(catChicken7Color), .catChicken8(catChicken8Color), .catChicken9(catChicken9Color), .catDog5(catDog5Color), .catDog6(catDog6Color), .catDog7(catDog7Color), .catDog8(catDog8Color), .catDog9(catDog9Color), .dogDog2(dogDog2Color), .dogDog3(dogDog3Color), .dogCat5(dogCat5Color), .dogCat6(dogCat6Color), .dogCat7(dogCat7Color), .dogCat8(dogCat8Color), .dogCat9(dogCat9Color), .dogChicken5(dogChicken5Color), .dogChicken6(dogChicken6Color), .dogChicken7(dogChicken7Color), .dogChicken8(dogChicken8Color), .dogChicken9(dogChicken9Color), .chickenChicken2(chickenChicken2Color), .chickenChicken3(chickenChicken3Color), .chickenDog5(chickenDog5Color), .chickenDog6(chickenDog6Color), .chickenDog7(chickenDog7Color), .chickenDog8(chickenDog8Color), .chickenDog9(chickenDog9Color), .chickenCat5(chickenCat5Color), .chickenCat6(chickenCat6Color), .chickenCat7(chickenCat7Color), .chickenCat8(chickenCat8Color), .chickenCat9(chickenCat9Color), .color(color));

//Current Player Points 
currentPlayerPoints pointsRegister(.clk(clk), .playerReset(playerReset), .winner1(winner1), .winner2(winner2), .player1(player1), .player2(player2));
//Screen Address Counters
addressScreenCounter screenCounter(.clk(clk), .addressScreenCounterReset(addressScreenCounterReset), .screenCount(screenCount), .screenCountLoad(screenCountLoad)); 

endmodule
