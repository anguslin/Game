module controller(userCont1, userCont2, cont1a, cont1b, cont1c, cont1d, cont1e, cont1f, cont1g, cont1h,  cont1i, cont2, cont3); 

//Signals controled by user inputs
input userCont1, userCont2; 
//Signals controlled by internal datapath
input cont1a, cont1b, cont1c, cont1d, cont1e, cont1f, cont1g, cont1h, cont1i, cont2, cont3; 

//States
`define s0 5'b00000
`define s1 5'b00001
`define s2 5'b00010
`define s3a 5'b00011
`define s3b 5'b00100
`define s3c 5'b00101
`define s3d 5'b00110
`define s3e 5'b00111
`define s3f 5'b01000
`define s3g 5'b01001
`define s3h 5'b01010
`define s3i 5'b01011
`define s4  5'b01100
`define s5a 5'b01101
`define s5b 5'b01110

`define blackScreen 5'b01111

//STATE ASSIGNMENTS
//Update state on clock; if reset, goes to state with 5'b00000 which is the first state
DFlipFlop #(5) (clk, nextState, currentState, reset);

always @(*) begin
	case(currentState)
		//Start Screen of game
		`s0: nextState = userCont1? `s1: currentState; //user controls next state

		//Wait for players to choose characters
		`s1: nextState = userCont2? `s2: currentState; //user controls next state

		//Depending on which combination of inputs the players choose
		`s2: begin //Internal signals decide next state
			if(cont1a)
				nextState = `s3a;
			else if(cont1b) 
				nextState = `s3b; 
			else if(cont1c) 
				nextState = `s3c;
			else if(cont1d) 
				nextState = `s3d;
			else if(cont1e)
				nextState = `s3e; 
			else if(cont1f) 
				nextState = `s3f;
			else if(cont1g)
				nextState = `s3g;
			else if(cont1h)
				nextState = `s3h;
			else if(cont1i)
				nextState = `s3i;
			else
				nextState = currentState; 
		end

		//Check if one of the players have 3 points, which = winner                                    
		`s3a: nextState = cont2? `s4: `s1; //Internal signals decide next state
		`s3b: nextState = cont2? `s4: `s1; 
		`s3c: nextState = cont2? `s4: `s1; 
		`s3d: nextState = cont2? `s4: `s1; 
		`s3e: nextState = cont2? `s4: `s1; 
		`s3f: nextState = cont2? `s4: `s1; 
		`s3g: nextState = cont2? `s4: `s1; 
		`s3h: nextState = cont2? `s4: `s1; 
		`s3i: nextState = cont2? `s4: `s1; 

		//Checks which player won 5a = player 1, 5b = player 2
		`s4: nextState = cont3? `s5a: `s5b; //Internal signals decide next state

		//Wait for users to restart the game, otherwise, display the winning screen
		`s5a: nextState = userCont3? `s0: currentState; //user controls next state
		`s5b: nextState = userCont3? `s0: currentState; //user controls next state
		
		default: nextState = `s0: //The moment the program starts, go to first state where everything gets reset
	endcase
end

//STATE LOGISTICS


always @(*) begin
	case(currentState)
		`s0: begin 

	end
	x	`s1: begin 
	
	end 
		`s2: begin 
	
	end
		`s3a: begin 
	
	end
		`s3b: begin 
	
	end
		`s3c: begin 
	
	end
		`s3d: begin 
	
	end
		`s3e: begin 
	
	end
		`s3f: begin 

	end
		`s3g: begin
	       
	end
		`s3h: begin 
	
	end
		`s3i: begin 
	
	end
		`s4: begin 
	
	end
		`s5a: begin 
	
	end
		`s5b: begin 
	
	end
		`BLACK_RESET: begin
		 controlReset = 1'b1;
	end
		`BLACK_LOOP: begin
		paint = 1'b1;
		countUp = 1'b1;
	end
		  
	endcase
end


//SIGNALS
yStart //Updates init vals into y
xStart 
xCountUp //Count up
yCountUp

xLoad
xSel

yLoad
ySel

xInitLoad
xInitSel

yInitLoad
yInitSel


endmodule


