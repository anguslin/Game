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

