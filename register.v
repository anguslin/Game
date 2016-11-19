
//The starting point of the xcoordinate

module xInitReg (clk, reset, xInitSel, xInit, xInitLoad);
input clk;
input [3:0] xInitSel;
output [7:0] xInit;
wire reg [7:0] xInitToLUpdate;

always @ (*) begin
	case(xInitSel)
		4'b0000: xInitToUpdate = 8'd0; //For Starting at the top left corner

		4'b0001: xInitToUpdate = 8'd36; //For the left side of the battles
		4'b0010: xInitToUpdate = 8'd30; 
		4'b0011: xInitToUpdate = 8'd24; 
		4'b0100: xInitToUpdate = 8'd18;
		4'b0101: xInitToUpdate = 8'd12;
		4'b0110: xInitToUpdate = 8'd6;
		4'b0111: xInitToUpdate = 8'd0;

		4'b1000: xInitToUpdate = 8'd90; //For the Right side of the battles
		4'b1001: xInitToUpdate = 8'd96; 
		4'b1010: xInitToUpdate = 8'd102; 
		4'b1011: xInitToUpdate = 8'd108; 
		4'b1100: xInitToUpdate = 8'd114; 
		4'b1101: xInitToUpdate = 8'd120; 

		default: xInitToUpdate = 8'b0;
	endcase
end
DFlipFlopEnable #(8) yInitReg(clk, xInitToUpdate, xInit, reset, xInitLoad);
endmodule


//The starting point of the ycoordinate

module yInitReg (clk, reset, yInitSel, yInit, yInitLoad);
input clk;
input [1:0] yInitSel;
output [6:0] yInit;
wire reg [6:0] yInitToLUpdate;

always @ (*) begin
	case(yInitSel)
		2'b00: yInitToUpdate = 7'd0; //For Starting at the top left corner
		2'b01: yInitToUpdate = 7'd30; //Height for the battles
		default: yInitToUpdate = 7'b0;
	endcase
end
DFlipFlopEnable #(7) yInitReg(clk, yInitToUpdate, yInit, reset, yInitLoad);
endmodule


//The actual Xcoordinates

module xReg(clk, reset, xSel, x, xLoad, xStart, countUp, xInit);
input clk, xCountUp;
input [1:0] xSel;
output [7:0] x;
wire reg [7:0] countUpTo;
wire reg [7:0] xToUpdate;

always@(*) begin
	case(xSel)
		2'b00: countUpTo = xInit; //If do not want x to move -> moving y
		2'b01: countUpTo = xInit + 40; //Counting for sprites -> xInit should be at the game location
		2'b10: countUpTo = xInit + 160; //Counting for screens -> xInit should be 0 in this case
		default: countUpTo = 0;
	endcase
end
assign xToUpdate = xStart? xInit: ((x == countUpTo)? x : (xCountUp? x+1 : x)); 
DFlipFlopEnable #(8) xReg(clk, xToUpdate, x, reset, xLoad);
endmodule


//The actual Ycoordinates

module yReg(clk, reset, ySel, y, yLoad, yStart, countUp, yInit);
input clk, yCountUp;
input [1:0] ySel;
output [6:0] y;
wire reg [6:0] countUpTo;
wire reg [6:0] yToUpdate;

always@(*) begin
	case(ySel)
		2'b00: countUpTo = yInit; //If do not want y to move -> moving x
		2'b01: countUpTo = yInit + 40; //Counting for sprites -> yInit should be at the game location
		2'b10: countUpTo = yInit + 160; //Counting for screens -> yInit should be 0 in this case
		default: countUpTo = 0;
	endcase
end
assign yToUpdate = yStart? yInit: ((y == countUpTo)? y : (yCountUp? y+1 : y)); //If yStart=1 then start at yInit and then if countUp = 1, then count 
DFlipFlopEnable #(7) yReg(clk, yToUpdate, y, reset, yLoad);
endmodule

//10 from title screens, 4 from chicken, 6 from dog, 12 from cat -> 10+4+6+12=32
module colour (clk, black, memorySel, title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, chickenLeft1, chickenLeft2, chickenRight1, chickenRight2, dogLeft1, dogLeft2, dogLeft3, dogRight1, dogRight2, dogRight3, catLeft1, catLeft2, catLeft3, catLeft4, catLeft5, catLeft6, catRight1, catRight2, catRight3, catRight4, catRight5, catRight6,  color);
input clk, black; //black is same as reset, except 000 corresponds to black
input [2:0] title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, chickenLeft1, chickenLeft2, chickenRight1, chickenRight2, dogLeft1, dogLeft2, dogLeft3, dogRight1, dogRight2, dogRight3, catLeft1, catLeft2, catLeft3, catLeft4, catLeft5, catLeft6, catRight1, catRight2, catRight3, catRight4, catRight5, catRight6;
input [4:0] memorySel;
output reg [2:0] color;

always @(*) begin
	casex({black,memorySel})
		6'b1xxxxx: color = 3'b000;
		6'b000000: color = title1;
		6'b000001: color = title2;
		6'b000010: color = title3;
		6'b000011: color = choose1;
		6'b000100: color = choose2;
		6'b000101: color = choose3;
		6'b000110: color = p1Win1;
		6'b000111: color = p1Win2;
		6'b001000: color = p2Win2;
		6'b001001: color = p2Win2;
		6'b001010: color = chickenLeft1;
		6'b001011: color = chickenLeft2;
		6'b001100: color = chickenRight1
		6'b001101: color = chickenRight2;
		6'b001110: color = dogLeft1;       
		6'b001111: color = dogLeft2;      
		6'b010000: color = dogLeft3;
		6'b010001: color = dogRight1;
		6'b010010: color = dogRight2;
		6'b010011: color = dogRight3;
		6'b010100: color = catLeft1;
		6'b010101: color = catLeft2;
		6'b010110: color = catLeft3;
		6'b010111: color = catLeft4;
		6'b011000: color = catLeft5;
		6'b011001: color = catLeft6;
		6'b011010: color = catRight1;
		6'b011011: color = catRight2;
		6'b011100: color = catRight3;
		6'b011101: color = catRight4;
		6'b011110: color = catRight5;
		6'b011111: color = catRight6;
		default: color = 3'b000;
	endcase
end

endmodule


