module controller(clk, userCont, userChoose, userResetGame, dogDog, dogCat, dogChicken, catDog, catCat, catChicken, chickenDog, chickenCat, chickenChicken, xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, xySel, black, playerReset, winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad, yInitSel, xInitSel, memorySel, plot, scenarioLoad, stateReset, screenDone);

//Signals controled by user inputs
input clk, userCont, userChoose, userResetGame, screenDone, stateReset; 
//Signals controlled by internal datapath
input screenDone, dogDog, dogCat, dogChicken, catDog, catCat, catChicken, chickenDog, chickenCat, chickenChicken;
//Output to datapath
output reg xInitReset, xInitLoad, yInitReset, yInitLoad, xCountUp, xReset, xLoad, yCountUp, yReset, yLoad, black, playerReset, winner1, winner2, playerLoad, addressScreenCounterReset, screenCountLoad, addressSpriteCounterReset, spriteCountLoad, plot, scenarioLoad;

output reg [1:0] yInitSel, xySel;
output reg [4:0] xInitSel; 
output reg [4:0] memorySel;

//Signal to wait
wire delay;
reg delaySignalReset;

//States
reg [6:0] nextState;
wire [6:0] currentState;

//Reset everything state
`define s0 7'd0

//Title Screen
`define sTitle1Start1 7'd1
`define sTitle1Start2 7'd2
`define sTitle1 7'd3
`define sTitle2Start1 7'd4
`define sTitle2Start2 7'd5
`define sTitle2 7'd6
`define sTitle3Start1 7'd7
`define sTitle3Start2 7'd8
`define sTitle3 7'd9

//Choose Screen
`define sChoose1Start1 7'd10
`define sChoose1Start2 7'd11
`define sChoose1 7'd12
`define sChoose2Start1 7'd13
`define sChoose2Start2 7'd14
`define sChoose2 7'd15
`define sChoose3Start1 7'd16
`define sChoose3Start2 7'd17
`define sChoose3 7'd18

//CatDog Sreens
`define sCatDog1Start1 7'd19  
`define sCatDog1Start2 7'd20  
`define sCatDog1 7'd21
`define sCatDog2Start1 7'd22  
`define sCatDog2Start2 7'd23  
`define sCatDog2 7'd24
`define sCatDog3Start1 7'd25  
`define sCatDog3Start2 7'd26  
`define sCatDog3 7'd27
`define sCatDog4Start1 7'd28  
`define sCatDog4Start2 7'd29  
`define sCatDog4 7'd30
`define sCatDog5Start1 7'd31  
`define sCatDog5Start2 7'd32  
`define sCatDog5 7'd33
`define sCatDog6Start1 7'd34  
`define sCatDog6Start2 7'd35  
`define sCatDog6 7'd36
`define sCatDog7Start1 7'd37  
`define sCatDog7Start2 7'd38  
`define sCatDog7 7'd39
`define sCatDog8Start1 7'd40  
`define sCatDog8Start2 7'd41  
`define sCatDog8 7'd42
`define sCatDog9Start1 7'd43  
`define sCatDog9Start2 7'd44  
`define sCatDog9 7'd45






`define sCatCat1Start1 7'd46  
`define sCatChicken1Start1 7'd47  
`define sChickenCat1Start1 7'd48  
`define sChickenDog1Start1 7'd49  
`define sChickenChicken1Start1 7'd50  
`define sDogCatStart1 7'd51  
`define sDogChickenStart1 7'd52  
`define sDogDogStart1 7'd53  


//Scenario
`define sScenario 7'd124

//Black Screens
`define sBlackScreen1 7'd125 
`define sBlackScreen2 7'd126  
`define sBlackScreen 7'd127

//Delay Signal
delaySignal delay1(.clk(clk), .delaySignalReset(delaySignalReset), .signal(delay)); //delays signal so it goes at 4Hz

//STATE ASSIGNMENTS
//Update state on clock; if reset, goes to state with 5'b00000 which is the first state
	DFlipFlop #(5) (clk, nextState, currentState, stateReset);

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
			`sScenario: nextState = catCat? `sCatCat1Start1: (catDog? `sCatDogStart1: (catChicken? `sCatChickenStart1: chickenCat? `sChickenCat1Start: (chickenDog? `sChickenDogStart1: (chickenChicken? `sChickenChickenStart1: (dogCat? `sDogCatStart1: (dogDog? `sDogDogStart1: (dogChicken? `sDogChickenStart1: `sCatCat1Start1)))))));

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
			`sCatDog9: nextState = delay? `sChoose1Start1: `sCatDog9;

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
			scenarioLoad = 1'b0;
		end

			`sCatDog1Start1: begin 
			//Loading the x and y inital coordinates -> xInitLoad, yInitLoad, xInitSel, yInitSel
			//Start the delay signal counting

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

	endcase
end



endmodule
