module controller(clk, userCont, userChoose, userResetGame, dogDog, dogCat, dogChicken, catDog, catCat, catChicken, chickenDog, chickenCat, chickenChicken, xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, xySel, black, playerReset, winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad, yInitSel, xInitSel, memorySel, plot, scenarioLoad, stateReset, screenDone, player1Wins, player2Wins);

//Signals controled by user inputs
input clk, userCont, userChoose, userResetGame, stateReset; 
//Signals controlled by internal datapath
input screenDone, player1Wins, player2Wins, dogDog, dogCat, dogChicken, catDog, catCat, catChicken, chickenDog, chickenCat, chickenChicken;
//Output to datapath
output reg xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, black, playerReset, winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad, plot, scenarioLoad;

output reg [1:0] yInitSel, xySel;
output reg [4:0] xInitSel; 
output reg [6:0] memorySel;

//Signal to wait
wire delay;
reg delaySignalReset;

//States
reg [7:0] nextState;
wire [7:0] currentState;

//Reset everything state
`define s0 8'd0

//Title Screen
`define sTitle1Start1 8'd1
`define sTitle1Start2 8'd2
`define sTitle1 8'd3
`define sTitle2Start1 8'd4
`define sTitle2Start2 8'd5
`define sTitle2 8'd6
`define sTitle3Start1 8'd7
`define sTitle3Start2 8'd8
`define sTitle3 8'd9

//Choose Screen
`define sChoose1Start1 8'd10
`define sChoose1Start2 8'd11
`define sChoose1 8'd12
`define sChoose2Start1 8'd13
`define sChoose2Start2 8'd14
`define sChoose2 8'd15
`define sChoose3Start1 8'd16
`define sChoose3Start2 8'd17
`define sChoose3 8'd18

//CatDog Sreens
`define sCatDog1Start1 8'd19  
`define sCatDog1Start2 8'd20  
`define sCatDog1 8'd21
`define sCatDog2Start1 8'd22  
`define sCatDog2Start2 8'd23  
`define sCatDog2 8'd24
`define sCatDog3Start1 8'd25  
`define sCatDog3Start2 8'd26  
`define sCatDog3 8'd27
`define sCatDog4Start1 8'd28  
`define sCatDog4Start2 8'd29  
`define sCatDog4 8'd30
`define sCatDog5Start1 8'd31  
`define sCatDog5Start2 8'd32  
`define sCatDog5 8'd33
`define sCatDog6Start1 8'd34  
`define sCatDog6Start2 8'd35  
`define sCatDog6 8'd36
`define sCatDog7Start1 8'd37  
`define sCatDog7Start2 8'd38  
`define sCatDog7 8'd39
`define sCatDog8Start1 8'd40  
`define sCatDog8Start2 8'd41  
`define sCatDog8 8'd42
`define sCatDog9Start1 8'd43  
`define sCatDog9Start2 8'd44  
`define sCatDog9 8'd45

//CatChicken Sreens
`define sCatChicken1Start1 8'd46  
`define sCatChicken1Start2 8'd47  
`define sCatChicken1 8'd48
`define sCatChicken2Start1 8'd49  
`define sCatChicken2Start2 8'd50  
`define sCatChicken2 8'd51
`define sCatChicken3Start1 8'd52  
`define sCatChicken3Start2 8'd53  
`define sCatChicken3 8'd54
`define sCatChicken4Start1 8'd55  
`define sCatChicken4Start2 8'd56  
`define sCatChicken4 8'd57
`define sCatChicken5Start1 8'd58  
`define sCatChicken5Start2 8'd59  
`define sCatChicken5 8'd60
`define sCatChicken6Start1 8'd61  
`define sCatChicken6Start2 8'd62  
`define sCatChicken6 8'd63
`define sCatChicken7Start1 8'd64  
`define sCatChicken7Start2 8'd65  
`define sCatChicken7 8'd66
`define sCatChicken8Start1 8'd67  
`define sCatChicken8Start2 8'd68  
`define sCatChicken8 8'd69
`define sCatChicken9Start1 8'd70  
`define sCatChicken9Start2 8'd71  
`define sCatChicken9 8'd72

//DogCat Sreens
`define sDogCat1Start1 8'd73  
`define sDogCat1Start2 8'd74  
`define sDogCat1 8'd75
`define sDogCat2Start1 8'd76  
`define sDogCat2Start2 8'd77  
`define sDogCat2 8'd78
`define sDogCat3Start1 8'd79  
`define sDogCat3Start2 8'd80  
`define sDogCat3 8'd81
`define sDogCat4Start1 8'd82  
`define sDogCat4Start2 8'd83  
`define sDogCat4 8'd84
`define sDogCat5Start1 8'd85  
`define sDogCat5Start2 8'd86  
`define sDogCat5 8'd87
`define sDogCat6Start1 8'd88  
`define sDogCat6Start2 8'd89  
`define sDogCat6 8'd90
`define sDogCat7Start1 8'd91  
`define sDogCat7Start2 8'd92  
`define sDogCat7 8'd93
`define sDogCat8Start1 8'd94  
`define sDogCat8Start2 8'd95  
`define sDogCat8 8'd96
`define sDogCat9Start1 8'd97  
`define sDogCat9Start2 8'd98  
`define sDogCat9 8'd99

//DogChicken Sreens
`define sDogChicken1Start1 8'd100 
`define sDogChicken1Start2 8'd101 
`define sDogChicken1 8'd102
`define sDogChicken2Start1 8'd103 
`define sDogChicken2Start2 8'd104 
`define sDogChicken2 8'd105
`define sDogChicken3Start1 8'd106 
`define sDogChicken3Start2 8'd107 
`define sDogChicken3 8'd108
`define sDogChicken4Start1 8'd109 
`define sDogChicken4Start2 8'd110 
`define sDogChicken4 8'd111
`define sDogChicken5Start1 8'd112 
`define sDogChicken5Start2 8'd113 
`define sDogChicken5 8'd114
`define sDogChicken6Start1 8'd115 
`define sDogChicken6Start2 8'd116 
`define sDogChicken6 8'd117
`define sDogChicken7Start1 8'd118 
`define sDogChicken7Start2 8'd119 
`define sDogChicken7 8'd120
`define sDogChicken8Start1 8'd121 
`define sDogChicken8Start2 8'd122 
`define sDogChicken8 8'd123
`define sDogChicken9Start1 8'd124 
`define sDogChicken9Start2 8'd125 
`define sDogChicken9 8'd126

//ChickenCat Sreens
`define sChickenCat1Start1 8'd127 
`define sChickenCat1Start2 8'd128 
`define sChickenCat1 8'd129 
`define sChickenCat2Start1 8'd130 
`define sChickenCat2Start2 8'd131 
`define sChickenCat2 8'd132
`define sChickenCat3Start1 8'd133 
`define sChickenCat3Start2 8'd134 
`define sChickenCat3 8'd135
`define sChickenCat4Start1 8'd136 
`define sChickenCat4Start2 8'd137 
`define sChickenCat4 8'd138
`define sChickenCat5Start1 8'd139 
`define sChickenCat5Start2 8'd140 
`define sChickenCat5 8'd141
`define sChickenCat6Start1 8'd142 
`define sChickenCat6Start2 8'd142 
`define sChickenCat6 8'd143
`define sChickenCat7Start1 8'd144 
`define sChickenCat7Start2 8'd145 
`define sChickenCat7 8'd146
`define sChickenCat8Start1 8'd147 
`define sChickenCat8Start2 8'd148 
`define sChickenCat8 8'd149
`define sChickenCat9Start1 8'd150 
`define sChickenCat9Start2 8'd151 
`define sChickenCat9 8'd152

//ChickenDog Sreens
`define sChickenDog1Start1 8'd153 
`define sChickenDog1Start2 8'd154 
`define sChickenDog1 8'd155
`define sChickenDog2Start1 8'd156 
`define sChickenDog2Start2 8'd157 
`define sChickenDog2 8'd158
`define sChickenDog3Start1 8'd159 
`define sChickenDog3Start2 8'd160 
`define sChickenDog3 8'd161
`define sChickenDog4Start1 8'd162 
`define sChickenDog4Start2 8'd163 
`define sChickenDog4 8'd164
`define sChickenDog5Start1 8'd165 
`define sChickenDog5Start2 8'd166 
`define sChickenDog5 8'd167
`define sChickenDog6Start1 8'd168 
`define sChickenDog6Start2 8'd169 
`define sChickenDog6 8'd170
`define sChickenDog7Start1 8'd171 
`define sChickenDog7Start2 8'd172 
`define sChickenDog7 8'd173
`define sChickenDog8Start1 8'd174 
`define sChickenDog8Start2 8'd175 
`define sChickenDog8 8'd176
`define sChickenDog9Start1 8'd177 
`define sChickenDog9Start2 8'd178 
`define sChickenDog9 8'd179

//CatCat Sreens
`define sCatCat1Start1 8'd180 
`define sCatCat1Start2 8'd181 
`define sCatCat1 8'd182
`define sCatCat2Start1 8'd183 
`define sCatCat2Start2 8'd185 
`define sCatCat2 8'd185
`define sCatCat3Start1 8'd186 
`define sCatCat3Start2 8'd187 
`define sCatCat3 8'd188
`define sCatCat4Start1 8'd189 
`define sCatCat4Start2 8'd190 
`define sCatCat4 8'd191
`define sCatCat5Start1 8'd192 
`define sCatCat5Start2 8'd193 
`define sCatCat5 8'd194
`define sCatCat6Start1 8'd195 
`define sCatCat6Start2 8'd196 
`define sCatCat6 8'd197

//DogDog Sreens
`define sDogDog1Start1 8'd198 
`define sDogDog1Start2 8'd199 
`define sDogDog1 8'd200
`define sDogDog2Start1 8'd201 
`define sDogDog2Start2 8'd202 
`define sDogDog2 8'd203
`define sDogDog3Start1 8'd204 
`define sDogDog3Start2 8'd205 
`define sDogDog3 8'd206
`define sDogDog4Start1 8'd207 
`define sDogDog4Start2 8'd208 
`define sDogDog4 8'd209
`define sDogDog5Start1 8'd210 
`define sDogDog5Start2 8'd211 
`define sDogDog5 8'd212
`define sDogDog6Start1 8'd213 
`define sDogDog6Start2 8'd214 
`define sDogDog6 8'd215

//ChickenChicken Sreens
`define sChickenChicken1Start1 8'd216 
`define sChickenChicken1Start2 8'd217 
`define sChickenChicken1 8'd218
`define sChickenChicken2Start1 8'd219 
`define sChickenChicken2Start2 8'd220 
`define sChickenChicken2 8'd221
`define sChickenChicken3Start1 8'd222 
`define sChickenChicken3Start2 8'd223 
`define sChickenChicken3 8'd224
`define sChickenChicken4Start1 8'd225 
`define sChickenChicken4Start2 8'd226 
`define sChickenChicken4 8'd227
`define sChickenChicken5Start1 8'd228 
`define sChickenChicken5Start2 8'd229 
`define sChickenChicken5 8'd230 
`define sChickenChicken6Start1 8'd231 
`define sChickenChicken6Start2 8'd232 
`define sChickenChicken6 8'd233

//Player 1 Wins 
`define sP1Wins1Start1 8'd234 
`define sP1Wins1Start1 8'd235
`define sP1Wins1 8'd236
`define sP1Wins2Start2 8'd237
`define sP1Wins2Start2 8'd238
`define sP1Wins2 8'd239

//Player 2 Wins 
`define sP2Wins1Start1 8'd240
`define sP2Wins1Start1 8'd241
`define sP2Wins1 8'd242
`define sP2Wins2Start2 8'd243
`define sP2Wins2Start2 8'd244
`define sP2Wins2 8'd245

//Scenario
`define sScenario 8'd246

//Black Screens
`define sBlackScreen1 8'd247 
`define sBlackScreen2 8'd248  
`define sBlackScreen 8'd249

//Delay Signal
delaySignal delay1(.clk(clk), .delaySignalReset(delaySignalReset), .signal(delay)); //delays signal so it goes at 4Hz

//STATE ASSIGNMENTS
//Update state on clock; if reset, goes to state with 5'b00000 which is the first state
	DFlipFlop #(8) (clk, nextState, currentState, stateReset);

	always @(*) begin
		case(currentState)
			//Start Screen of game
			`s0: nextState = `sTitle1Start1; //reset everything to 0

			//Title Screen moves to Choose screen when user presses KEY[1]
			`sTitle1Start1: nextState = `sTitle1Start2; //Loading xInitial and yInitial Values 
			`sTitle1Start2: nextState = `sTitle1; //Loading x Values and yValues
			`sTitle1: nextState = userCont? `sChoose1Start1 : (delay? `sTitle2Start1: `sTitle1); //Clock keeps updating

			`sTitle2Start1: nextState = `sTitle2Start2; 
			`sTitle2Start2: nextState = `sTitle2; 
			`sTitle2: nextState = userCont? `sChoose1Start1 : (delay? `sTitle3Start1: `sTitle2); 

			`sTitle3Start1: nextState = `sTitle3Start2; 
			`sTitle3Start2: nextState = `sTitle3; 
			`sTitle3: nextState = userCont? `sChoose1Start1 : (delay? `sTitle1Start1: `sTitle3); 

			//Title Screen moves to Choose screen when user presses KEY[1]
			`sChoose1Start1: nextState = `sChoose1Start2; //Loading xInitial and yInitial Values 
			`sChoose1Start2: nextState = `sChoose1; //Loading x Values and yValues
			`sChoose1: nextState = userChoose? `sScenario : (delay? `sChoose2Start1: `sChoose1); //Clock keeps updating

			`sChoose2Start1: nextState = `sChoose2Start2; 
			`sChoose2Start2: nextState = `sChoose2; 
			`sChoose2: nextState = userChoose? `sScenario : (delay? `sChoose3Start1: `sChoose2); 

			`sChoose3Start1: nextState = `sChoose3Start2; 
			`sChoose3Start2: nextState = `sChoose3; 
			`sChoose3: nextState = userChoose? `sScenario : (delay? `sChoose1Start1: `sChoose3); 
			
			//Default if it doesnt specify is Cat Cat Scenario
			`sScenario: nextState = catCat? `sCatCat1Start1: (catDog? `sCatDog1Start1: (catChicken? `sCatChicken1Start1: (chickenCat? `sChickenCat1Start1: (chickenDog? `sChickenDog1Start1: (chickenChicken? `sChickenChicken1Start1: (dogCat? `sDogCat1Start1: (dogDog? `sDogDog1Start1: (dogChicken? `sDogChicken1Start1: `sCatCat1Start1))))))));
			//CatDog Scenario
			`sCatDog1Start1: nextState = `sCatDog1Start2;
			`sCatDog1Start2: nextState = `sCatDog1;
			`sCatDog1: nextState = delay? `sCatDog2Start1: `sCatDog1;

			`sCatDog2Start1: nextState = `sCatDog2Start2;
			`sCatDog2Start2: nextState = `sCatDog2;
			`sCatDog2: nextState = delay? `sCatDog3Start1: `sCatDog2;

			`sCatDog3Start1: nextState = `sCatDog3Start2;
			`sCatDog3Start2: nextState = `sCatDog3;
			`sCatDog3: nextState = delay? `sCatDog4Start1: `sCatDog3;

			`sCatDog4Start1: nextState = `sCatDog4Start2;
			`sCatDog4Start2: nextState = `sCatDog4;
			`sCatDog4: nextState = delay? `sCatDog5Start1: `sCatDog4;

			`sCatDog5Start1: nextState = `sCatDog5Start2;
			`sCatDog5Start2: nextState = `sCatDog5;
			`sCatDog5: nextState = delay? `sCatDog6Start1: `sCatDog5;

			`sCatDog6Start1: nextState = `sCatDog6Start2;
			`sCatDog6Start2: nextState = `sCatDog6;
			`sCatDog6: nextState = delay? `sCatDog7Start1: `sCatDog6;

			`sCatDog7Start1: nextState = `sCatDog7Start2;
			`sCatDog7Start2: nextState = `sCatDog7;
			`sCatDog7: nextState = delay? `sCatDog8Start1: `sCatDog7;

			`sCatDog8Start1: nextState = `sCatDog8Start2;
			`sCatDog8Start2: nextState = `sCatDog8;
			`sCatDog8: nextState = delay? `sCatDog9Start1: `sCatDog8;

			`sCatDog9Start1: nextState = `sCatDog9Start2;
			`sCatDog9Start2: nextState = `sCatDog9;
			`sCatDog9: nextState = delay? (player1Wins? `sP1Wins1Start1 :(player2Wins? `sP2Wins1Start1: `sChoose1Start1)): `sCatDog9;

			//CatChicken Scenario
			`sCatChicken1Start1: nextState = `sCatChicken1Start2;
			`sCatChicken1Start2: nextState = `sCatChicken1;
			`sCatChicken1: nextState = delay? `sCatChicken2Start1: `sCatChicken1;

			`sCatChicken2Start1: nextState = `sCatChicken2Start2;
			`sCatChicken2Start2: nextState = `sCatChicken2;
			`sCatChicken2: nextState = delay? `sCatChicken3Start1: `sCatChicken2;

			`sCatChicken3Start1: nextState = `sCatChicken3Start2;
			`sCatChicken3Start2: nextState = `sCatChicken3;
			`sCatChicken3: nextState = delay? `sCatChicken4Start1: `sCatChicken3;

			`sCatChicken4Start1: nextState = `sCatChicken4Start2;
			`sCatChicken4Start2: nextState = `sCatChicken4;
			`sCatChicken4: nextState = delay? `sCatChicken5Start1: `sCatChicken4;

			`sCatChicken5Start1: nextState = `sCatChicken5Start2;
			`sCatChicken5Start2: nextState = `sCatChicken5;
			`sCatChicken5: nextState = delay? `sCatChicken6Start1: `sCatChicken5;

			`sCatChicken6Start1: nextState = `sCatChicken6Start2;
			`sCatChicken6Start2: nextState = `sCatChicken6;
			`sCatChicken6: nextState = delay? `sCatChicken7Start1: `sCatChicken6;

			`sCatChicken7Start1: nextState = `sCatChicken7Start2;
			`sCatChicken7Start2: nextState = `sCatChicken7;
			`sCatChicken7: nextState = delay? `sCatChicken8Start1: `sCatChicken7;

			`sCatChicken8Start1: nextState = `sCatChicken8Start2;
			`sCatChicken8Start2: nextState = `sCatChicken8;
			`sCatChicken8: nextState = delay? `sCatChicken9Start1: `sCatChicken8;

			`sCatChicken9Start1: nextState = `sCatChicken9Start2;
			`sCatChicken9Start2: nextState = `sCatChicken9;
			`sCatChicken9: nextState = delay? `sChoose1Start1: `sCatChicken9;

			//ChickenCat Scenario
			`sChickenCat1Start1: nextState = `sChickenCat1Start2;
			`sChickenCat1Start2: nextState = `sChickenCat1;
			`sChickenCat1: nextState = delay? `sChickenCat2Start1: `sChickenCat1;

			`sChickenCat2Start1: nextState = `sChickenCat2Start2;
			`sChickenCat2Start2: nextState = `sChickenCat2;
			`sChickenCat2: nextState = delay? `sChickenCat3Start1: `sChickenCat2;

			`sChickenCat3Start1: nextState = `sChickenCat3Start2;
			`sChickenCat3Start2: nextState = `sChickenCat3;
			`sChickenCat3: nextState = delay? `sChickenCat4Start1: `sChickenCat3;

			`sChickenCat4Start1: nextState = `sChickenCat4Start2;
			`sChickenCat4Start2: nextState = `sChickenCat4;
			`sChickenCat4: nextState = delay? `sChickenCat5Start1: `sChickenCat4;

			`sChickenCat5Start1: nextState = `sChickenCat5Start2;
			`sChickenCat5Start2: nextState = `sChickenCat5;
			`sChickenCat5: nextState = delay? `sChickenCat6Start1: `sChickenCat5;

			`sChickenCat6Start1: nextState = `sChickenCat6Start2;
			`sChickenCat6Start2: nextState = `sChickenCat6;
			`sChickenCat6: nextState = delay? `sChickenCat7Start1: `sChickenCat6;

			`sChickenCat7Start1: nextState = `sChickenCat7Start2;
			`sChickenCat7Start2: nextState = `sChickenCat7;
			`sChickenCat7: nextState = delay? `sChickenCat8Start1: `sChickenCat7;

			`sChickenCat8Start1: nextState = `sChickenCat8Start2;
			`sChickenCat8Start2: nextState = `sChickenCat8;
			`sChickenCat8: nextState = delay? `sChickenCat9Start1: `sChickenCat8;

			`sChickenCat9Start1: nextState = `sChickenCat9Start2;
			`sChickenCat9Start2: nextState = `sChickenCat9;
			`sChickenCat9: nextState = delay? `sChoose1Start1: `sChickenCat9;

			//ChickenDog Scenario
			`sChickenDog1Start1: nextState = `sChickenDog1Start2;
			`sChickenDog1Start2: nextState = `sChickenDog1;
			`sChickenDog1: nextState = delay? `sChickenDog2Start1: `sChickenDog1;

			`sChickenDog2Start1: nextState = `sChickenDog2Start2;
			`sChickenDog2Start2: nextState = `sChickenDog2;
			`sChickenDog2: nextState = delay? `sChickenDog3Start1: `sChickenDog2;

			`sChickenDog3Start1: nextState = `sChickenDog3Start2;
			`sChickenDog3Start2: nextState = `sChickenDog3;
			`sChickenDog3: nextState = delay? `sChickenDog4Start1: `sChickenDog3;

			`sChickenDog4Start1: nextState = `sChickenDog4Start2;
			`sChickenDog4Start2: nextState = `sChickenDog4;
			`sChickenDog4: nextState = delay? `sChickenDog5Start1: `sChickenDog4;

			`sChickenDog5Start1: nextState = `sChickenDog5Start2;
			`sChickenDog5Start2: nextState = `sChickenDog5;
			`sChickenDog5: nextState = delay? `sChickenDog6Start1: `sChickenDog5;

			`sChickenDog6Start1: nextState = `sChickenDog6Start2;
			`sChickenDog6Start2: nextState = `sChickenDog6;
			`sChickenDog6: nextState = delay? `sChickenDog7Start1: `sChickenDog6;

			`sChickenDog7Start1: nextState = `sChickenDog7Start2;
			`sChickenDog7Start2: nextState = `sChickenDog7;
			`sChickenDog7: nextState = delay? `sChickenDog8Start1: `sChickenDog7;

			`sChickenDog8Start1: nextState = `sChickenDog8Start2;
			`sChickenDog8Start2: nextState = `sChickenDog8;
			`sChickenDog8: nextState = delay? `sChickenDog9Start1: `sChickenDog8;

			`sChickenDog9Start1: nextState = `sChickenDog9Start2;
			`sChickenDog9Start2: nextState = `sChickenDog9;
			`sChickenDog9: nextState = delay? `sChoose1Start1: `sChickenDog9;

			//DogCat Scenario
			`sDogCat1Start1: nextState = `sDogCat1Start2;
			`sDogCat1Start2: nextState = `sDogCat1;
			`sDogCat1: nextState = delay? `sDogCat2Start1: `sDogCat1;

			`sDogCat2Start1: nextState = `sDogCat2Start2;
			`sDogCat2Start2: nextState = `sDogCat2;
			`sDogCat2: nextState = delay? `sDogCat3Start1: `sDogCat2;

			`sDogCat3Start1: nextState = `sDogCat3Start2;
			`sDogCat3Start2: nextState = `sDogCat3;
			`sDogCat3: nextState = delay? `sDogCat4Start1: `sDogCat3;

			`sDogCat4Start1: nextState = `sDogCat4Start2;
			`sDogCat4Start2: nextState = `sDogCat4;
			`sDogCat4: nextState = delay? `sDogCat5Start1: `sDogCat4;

			`sDogCat5Start1: nextState = `sDogCat5Start2;
			`sDogCat5Start2: nextState = `sDogCat5;
			`sDogCat5: nextState = delay? `sDogCat6Start1: `sDogCat5;

			`sDogCat6Start1: nextState = `sDogCat6Start2;
			`sDogCat6Start2: nextState = `sDogCat6;
			`sDogCat6: nextState = delay? `sDogCat7Start1: `sDogCat6;

			`sDogCat7Start1: nextState = `sDogCat7Start2;
			`sDogCat7Start2: nextState = `sDogCat7;
			`sDogCat7: nextState = delay? `sDogCat8Start1: `sDogCat7;

			`sDogCat8Start1: nextState = `sDogCat8Start2;
			`sDogCat8Start2: nextState = `sDogCat8;
			`sDogCat8: nextState = delay? `sDogCat9Start1: `sDogCat8;

			`sDogCat9Start1: nextState = `sDogCat9Start2;
			`sDogCat9Start2: nextState = `sDogCat9;
			`sDogCat9: nextState = delay? `sChoose1Start1: `sDogCat9;

			//DogChicken Scenario
			`sDogChicken1Start1: nextState = `sDogChicken1Start2;
			`sDogChicken1Start2: nextState = `sDogChicken1;
			`sDogChicken1: nextState = delay? `sDogChicken2Start1: `sDogChicken1;

			`sDogChicken2Start1: nextState = `sDogChicken2Start2;
			`sDogChicken2Start2: nextState = `sDogChicken2;
			`sDogChicken2: nextState = delay? `sDogChicken3Start1: `sDogChicken2;

			`sDogChicken3Start1: nextState = `sDogChicken3Start2;
			`sDogChicken3Start2: nextState = `sDogChicken3;
			`sDogChicken3: nextState = delay? `sDogChicken4Start1: `sDogChicken3;

			`sDogChicken4Start1: nextState = `sDogChicken4Start2;
			`sDogChicken4Start2: nextState = `sDogChicken4;
			`sDogChicken4: nextState = delay? `sDogChicken5Start1: `sDogChicken4;

			`sDogChicken5Start1: nextState = `sDogChicken5Start2;
			`sDogChicken5Start2: nextState = `sDogChicken5;
			`sDogChicken5: nextState = delay? `sDogChicken6Start1: `sDogChicken5;

			`sDogChicken6Start1: nextState = `sDogChicken6Start2;
			`sDogChicken6Start2: nextState = `sDogChicken6;
			`sDogChicken6: nextState = delay? `sDogChicken7Start1: `sDogChicken6;

			`sDogChicken7Start1: nextState = `sDogChicken7Start2;
			`sDogChicken7Start2: nextState = `sDogChicken7;
			`sDogChicken7: nextState = delay? `sDogChicken8Start1: `sDogChicken7;

			`sDogChicken8Start1: nextState = `sDogChicken8Start2;
			`sDogChicken8Start2: nextState = `sDogChicken8;
			`sDogChicken8: nextState = delay? `sDogChicken9Start1: `sDogChicken8;

			`sDogChicken9Start1: nextState = `sDogChicken9Start2;
			`sDogChicken9Start2: nextState = `sDogChicken9;
			`sDogChicken9: nextState = delay? `sChoose1Start1: `sDogChicken9;

			//CatCat Scenario
			`sCatCat1Start1: nextState = `sCatCat1Start2;
			`sCatCat1Start2: nextState = `sCatCat1;
			`sCatCat1: nextState = delay? `sCatCat2Start1: `sCatCat1;

			`sCatCat2Start1: nextState = `sCatCat2Start2;
			`sCatCat2Start2: nextState = `sCatCat2;
			`sCatCat2: nextState = delay? `sCatCat3Start1: `sCatCat2;

			`sCatCat3Start1: nextState = `sCatCat3Start2;
			`sCatCat3Start2: nextState = `sCatCat3;
			`sCatCat3: nextState = delay? `sCatCat4Start1: `sCatCat3;

			`sCatCat4Start1: nextState = `sCatCat4Start2;
			`sCatCat4Start2: nextState = `sCatCat4;
			`sCatCat4: nextState = delay? `sCatCat5Start1: `sCatCat4;

			`sCatCat5Start1: nextState = `sCatCat5Start2;
			`sCatCat5Start2: nextState = `sCatCat5;
			`sCatCat5: nextState = delay? `sCatCat6Start1: `sCatCat5;

			`sCatCat6Start1: nextState = `sCatCat6Start2;
			`sCatCat6Start2: nextState = `sCatCat6;
			`sCatCat6: nextState = delay? `sChoose1Start1: `sCatCat6;

			//DogDog Scenario
			`sDogDog1Start1: nextState = `sDogDog1Start2;
			`sDogDog1Start2: nextState = `sDogDog1;
			`sDogDog1: nextState = delay? `sDogDog2Start1: `sDogDog1;

			`sDogDog2Start1: nextState = `sDogDog2Start2;
			`sDogDog2Start2: nextState = `sDogDog2;
			`sDogDog2: nextState = delay? `sDogDog3Start1: `sDogDog2;

			`sDogDog3Start1: nextState = `sDogDog3Start2;
			`sDogDog3Start2: nextState = `sDogDog3;
			`sDogDog3: nextState = delay? `sDogDog4Start1: `sDogDog3;

			`sDogDog4Start1: nextState = `sDogDog4Start2;
			`sDogDog4Start2: nextState = `sDogDog4;
			`sDogDog4: nextState = delay? `sDogDog5Start1: `sDogDog4;

			`sDogDog5Start1: nextState = `sDogDog5Start2;
			`sDogDog5Start2: nextState = `sDogDog5;
			`sDogDog5: nextState = delay? `sDogDog6Start1: `sDogDog5;

			`sDogDog6Start1: nextState = `sDogDog6Start2;
			`sDogDog6Start2: nextState = `sDogDog6;
			`sDogDog6: nextState = delay? `sChoose1Start1: `sDogDog6;

			//ChickenChicken Scenario
			`sChickenChicken1Start1: nextState = `sChickenChicken1Start2;
			`sChickenChicken1Start2: nextState = `sChickenChicken1;
			`sChickenChicken1: nextState = delay? `sChickenChicken2Start1: `sChickenChicken1;

			`sChickenChicken2Start1: nextState = `sChickenChicken2Start2;
			`sChickenChicken2Start2: nextState = `sChickenChicken2;
			`sChickenChicken2: nextState = delay? `sChickenChicken3Start1: `sChickenChicken2;

			`sChickenChicken3Start1: nextState = `sChickenChicken3Start2;
			`sChickenChicken3Start2: nextState = `sChickenChicken3;
			`sChickenChicken3: nextState = delay? `sChickenChicken4Start1: `sChickenChicken3;

			`sChickenChicken4Start1: nextState = `sChickenChicken4Start2;
			`sChickenChicken4Start2: nextState = `sChickenChicken4;
			`sChickenChicken4: nextState = delay? `sChickenChicken5Start1: `sChickenChicken4;

			`sChickenChicken5Start1: nextState = `sChickenChicken5Start2;
			`sChickenChicken5Start2: nextState = `sChickenChicken5;
			`sChickenChicken5: nextState = delay? `sChickenChicken6Start1: `sChickenChicken5;

			`sChickenChicken6Start1: nextState = `sChickenChicken6Start2;
			`sChickenChicken6Start2: nextState = `sChickenChicken6;
			`sChickenChicken6: nextState = delay? `sChoose1Start1: `sChickenChicken6;

			//P1Wins
			`sP1Wins1Start1: nextState = `sP1Wins1Start2; 
			`sP1Wins1Start2: nextState = `sP1Wins1; 
			`sP1Wins1: nextState = userResetGame? `sTitle1Start1 : (delay? `sP1Wins2Start1: `sP1Wins1); 

			`sP1Wins2Start1: nextState = `sP1Wins2Start2; 
			`sP1Wins2Start2: nextState = `sP1Wins2; 
			`sP1Wins2: nextState = userResetGame? `sTitle1Start1 : (delay? `sP1Wins1Start1: `sP1Wins2); 

			//P2Wins
			`sP2Wins1Start1: nextState = `sP2Wins1Start2; 
			`sP2Wins1Start2: nextState = `sP2Wins1; 
			`sP2Wins1: nextState = userResetGame? `sTitle1Start1 : (delay? `sP2Wins2Start1: `sP2Wins1); 

			`sP2Wins2Start1: nextState = `sP2Wins2Start2; 
			`sP2Wins2Start2: nextState = `sP2Wins2; 
			`sP2Wins2: nextState = userResetGame? `sTitle1Start1 : (delay? `sP2Wins1Start1: `sP2Wins2); 

			default: nextState = `s0; //The moment the program starts, go to first state where everything gets reset
			endcase
		end

		always @(*) begin
			case(currentState)
				`s0: begin 
				//Inital xy registers
				xInitReset = 1'b1; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b1; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b1; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b1; yLoad = 1'b0; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd0;
				//Player Updating Registers
				playerReset = 1'b1; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b1; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;

			end
			`sTitle1Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd0;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		`sTitle1Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd0;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end

		`sTitle1: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b1; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b1; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b01;
				//Color Register
				black = 1'b0; memorySel = 7'd0;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0; winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b1;
		end
		
		`sTitle2Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd1;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		
		`sTitle2Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd1;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		`sTitle2: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b1; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b1; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b01;
				//Color Register
				black = 1'b0; memorySel = 7'd1;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0; winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b1;
		end
		`sTitle3Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd2;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		
		`sTitle3Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b00;
				//Color Register
				black = 1'b0; memorySel = 7'd2;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; screenCountLoad = 1'b0;
				//Counting for sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		`sTitle3: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b1; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b1; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b01;
				//Color Register
				black = 1'b0; memorySel = 7'd2;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0; winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b1;
		end
		
	
	`sChoose1Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd3;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b1;
		end
		
		`sChoose1Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sChoose1: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sChoose2Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd4;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		
		`sChoose2Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sChoose2: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sChoose3Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd5;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		
		`sChoose3Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sChoose3: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

		`sScenario: begin
			scenarioLoad = 1'b0; xCountUp = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yLoad = 1'b0; xySel = 2'b00; screenCountLoad = 1'b0; plot = 1'b0;
		end

			`sCatDog1Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

		
				winner1 = 1'b1;  winner2 = 1'b0; playerLoad = 1'b1;
				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd13;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog1Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset
		
				winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog1: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad


				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

	`sCatDog2Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd14;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog2Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog2: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

		`sCatDog3Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd15;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog3Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog3: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sCatDog4Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd16;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog4Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog4: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end





`sCatDog5Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd17;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog5Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog5: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sCatDog6Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd18;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog6Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog6: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sCatDog7Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd19;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog7Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog7: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end


`sCatDog8Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd20;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog8Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog8: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

	`sCatDog9Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd21;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		
		`sCatDog9Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sCatDog9: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end


`sBlackScreen1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b00;
				//Color Register
				black = 1'b1; memorySel = 5'b00000;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end



		`sBlackScreen2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b00;
				//Color Register
				black = 1'b1; memorySel = 5'b00000;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end
		`sBlackScreen: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b00000; xInitLoad = 1'b0; yInitReset = 1'b0; yInitSel = 2'b00; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xCountUp = 1'b1; xReset = 1'b0; xLoad = 1'b1; yCountUp = 1'b1; yReset = 1'b0; yLoad = 1'b1; xySel = 2'b01;
				//Color Register
				black = 1'b1; memorySel = 5'b00000;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0; winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b0;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b1;
				//Loading the Scenario
				scenarioLoad = 1'b0;
		end







	`sP1Wins1Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd6;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
				//Loading the Scenario
				scenarioLoad = 1'b1;
		end
		
		`sP1Wins1Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sP1Wins1: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end

`sP1Wins2Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

				//Inital xy registers
				xInitReset = 1'b0; xInitSel = 5'b0; xInitLoad = 1'b1; yInitReset = 1'b0; yInitSel = 2'b0; yInitLoad = 1'b1;
				//x and y vga Coordinate Registers
				xCountUp = 1'b0; xReset = 1'b0; xLoad = 1'b0; yCountUp = 1'b0; yReset = 1'b0; yLoad = 1'b0; xySel = 2'b0;
				//Color Register
				black = 1'b0; memorySel = 7'd7;
				//Player Updating Registers
				playerReset = 1'b0; winner1 = 1'b0;  winner2 = 1'b0; playerLoad = 1'b0;
				//Delaying internal signals
				delaySignalReset = 1'b1; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b0;
				//Counting fir sprites (40x40)
				addressSpriteCounterReset = 1'b0; spriteCountLoad = 1'b0;
				//Plotting for VGA
				plot = 1'b0;
		end
		
		`sP1Wins2Start2: begin 
		//Loading the inital coordinates into x and y before starting to count -> xLoad, yLoad, xySel
		//Also make sure Screen Counter is at 0 -> AddressscreenCounterReset

				//Inital xy registers
				xInitLoad = 1'b0; yInitLoad = 1'b0;
				//x and y vga Coordinate Registers
				xLoad = 1'b1; yLoad = 1'b1;
				//Delaying internal signals
				delaySignalReset = 1'b0; 
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b1; 
		end
		`sP1Wins2: begin
//Go into a loop of loading the values of the respective ROM color until it finishes loading -> memorySel, xCountUp, xLoad, yCountUp, yLoad, addressScreenCountLoad

				xCountUp = 1'b1; xLoad = 1'b1; yCountUp = 1'b1; yLoad = 1'b1; xySel = 2'b01;
				//Counting for screens (160x120)
				addressScreenCounterReset = 1'b0; screenCountLoad = 1'b1;
				//Plotting for VGA
				plot = 1'b1;
		end




	endcase
end



endmodule
