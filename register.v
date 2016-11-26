
//The starting point of the xcoordinate

module xInitReg (clk, xInitReset, xInitSel, xInit, xInitLoad);
input clk, xInitReset, xInitLoad;
input [4:0] xInitSel;
output [7:0] xInit;
reg [7:0] xInitToUpdate;

always @ (*) begin
	case(xInitSel)
		5'b00000: xInitToUpdate = 8'd0; //For Starting at the top left corner

		5'b00001: xInitToUpdate = 8'd36; //For the left side of the battles
		5'b00010: xInitToUpdate = 8'd30; 
		5'b00011: xInitToUpdate = 8'd24; 
		5'b00100: xInitToUpdate = 8'd18;
		5'b00101: xInitToUpdate = 8'd12;
		5'b00110: xInitToUpdate = 8'd6;
		5'b00111: xInitToUpdate = 8'd0;

		5'b01000: xInitToUpdate = 8'd90; //For the Right side of the battles
		5'b01001: xInitToUpdate = 8'd96; 
		5'b01010: xInitToUpdate = 8'd102; 
		5'b01011: xInitToUpdate = 8'd108; 
		5'b01100: xInitToUpdate = 8'd114; 
		5'b01101: xInitToUpdate = 8'd120; 
		
		5'b01110: xInitToUpdate = 8'd84; //For moving states
		5'b01111: xInitToUpdate = 8'd78;
		5'b10000: xInitToUpdate = 8'd72;
		5'b10001: xInitToUpdate = 8'd66;
		5'b10010: xInitToUpdate = 8'd60;
		5'b10011: xInitToUpdate = 8'd54;
		5'b10100: xInitToUpdate = 8'd48;
		5'b10101: xInitToUpdate = 8'd42;


		default: xInitToUpdate = 8'b0;
	endcase
end
DFlipFlopEnable #(8) xInitReg(clk, xInitToUpdate, xInit, xInitReset, xInitLoad);
endmodule

//The starting point of the ycoordinate

module yInitReg (clk, yInitReset, yInitSel, yInit, yInitLoad);
input clk, yInitReset, yInitLoad;
input [1:0] yInitSel;
output [6:0] yInit;
reg [6:0] yInitToUpdate;

always @ (*) begin
	case(yInitSel)
		2'b00: yInitToUpdate = 7'd0; //For Starting at the top left corner
		2'b01: yInitToUpdate = 7'd30; //Height for the battles
		default: yInitToUpdate = 7'b0;
	endcase
end
DFlipFlopEnable #(7) yInitReg(clk, yInitToUpdate, yInit, yInitReset, yInitLoad);
endmodule


//The actual x and y coordinates

module xyReg(clk, xReset, yReset, xySel, x, y, xLoad, yLoad, xStart, yStart, xCountUp, yCountUp, xInit, yInit, screenDone);
input clk, xCountUp, xReset, xLoad, xStart, yCountUp, yReset, yLoad, yStart;
input [1:0] xySel;
input [7:0] xInit;
input [6:0] yInit;
output reg screenDone;
output [7:0] x; 
output [6:0] y;
reg [7:0] xToUpdate;
reg [6:0] yToUpdate;

always@(*) begin
	case(xySel)
		2'b00: begin
			yToUpdate = yInit;
			xToUpdate = xInit;
			screenDone = 0;
		end
		2'b01: begin //Whole Screen Reading
		       if (y < 120 && x == 160 && yCountUp) begin
					yToUpdate = y + 1;
					xToUpdate = 1;
					screenDone = 0;
			end else if (x < 160 && xCountUp) begin
					xToUpdate = x + 1;
					screenDone = 0;
					end else
					screenDone = 1;
			end
		2'b10: begin
	       		if (y < yInit + 40 && x == xInit + 40 && yCountUp) begin
					yToUpdate = y + 1;
					xToUpdate = xInit + 1;
					screenDone = 0;
			end else if (x < xInit + 40 && xCountUp) begin
					xToUpdate = x + 1;
					screenDone = 0;
					end else 
					screenDone = 1;
		end	
	endcase
end

DFlipFlopEnable #(8) xReg(clk, xToUpdate, x, xReset, xLoad);
DFlipFlopEnable #(7) yReg(clk, yToUpdate, y, yReset, yLoad);

endmodule


//10 from title screens, 4 from chicken, 6 from dog, 12 from cat -> 10+4+6+12=32
module color(clk, black, memorySel, title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, chickenLeft1, chickenLeft2, chickenRight1, chickenRight2, dogLeft1, dogLeft2, dogLeft3, dogRight1, dogRight2, dogRight3, catLeft1, catLeft2, catLeft3, catLeft4, catLeft5, catLeft6, catRight1, catRight2, catRight3, catRight4, catRight5, catRight6,  color);
input clk, black; //black is same as Reset, except 000 corresponds to black
input [2:0] title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, chickenLeft1, chickenLeft2, chickenRight1, chickenRight2, dogLeft1, dogLeft2, dogLeft3, dogRight1, dogRight2, dogRight3, catLeft1, catLeft2, catLeft3, catLeft4, catLeft5, catLeft6, catRight1, catRight2, catRight3, catRight4, catRight5, catRight6;
input [4:0] memorySel;
output reg [2:0] color;

always @(*) begin
	casex({black,memorySel}) //Does not rely on clk to update
		7'd1 : color = 3'b000;
		7'd2 : color = title1;
		7'd3 : color = title2;
		7'd4 : color = title3;
		7'd5 : color = choose1;
		7'd6 : color = choose2;
		7'd7 : color = choose3;
		7'd8 : color = p1Win1;
		7'd9 : color = p1Win2;
		7'd10: color = p2Win2;
		7'd11: color = p2Win2;
		7'd12: color = catCat1; 
		7'd13: color = catCat2;
		7'd14: color = catCat3;
		7'd15: color = catDog1;
		7'd16: color = catDog2;       
		7'd17: color = catDog3;      
		7'd18: color = catDog4;
		7'd19: color = catDog5;
		7'd20: color = catDog6;
		7'd21: color = catDog7;
		7'd22: color = catDog8;
		7'd23: color = catDog9;
		7'd24: color = catChicken1;
		7'd25: color = catChicken2; 
		7'd26: color = catChicken3;  
		7'd27: color = catChicken4;
		7'd28: color = catChicken5;
		7'd29: color = catChicken6;
		7'd30: color = catChicken7;
		7'd31: color = catChicken8;
		7'd32: color = catChicken9;
		7'd33: color = chickenCat1;
		7'd34: color = chickenCat2;
		7'd35: color = chickenCat3;
		7'd36: color = chickenCat4;
		7'd37: color = chickenCat5;
		7'd38: color = chickenCat6;
		7'd39: color = chickenCat7;
		7'd40: color = chickenCat8;
		7'd41: color = chickenCat9;
		7'd42: color = chickenChicken1; 
		7'd43: color = chickenChicken2;
		7'd44: color = chickenChicken3;
		7'd45: color = chickenDog1; 
		7'd46: color = chickenDog2;
		7'd47: color = chickenDog3;
		7'd48: color = chickenDog4;
		7'd49: color = chickenDog5;
		7'd50: color = chickenDog6;
		7'd51: color = chickenDog7;
		7'd52: color = chickenDog8;
		7'd53: color = chickenDog9;
		7'd54: color = dogCat1; 
		7'd55: color = dogCat2; 
		7'd56: color = dogCat3;
		7'd57: color = dogCat4;
		7'd58: color = dogCat5;
		7'd59: color = dogCat6;
		7'd60: color = dogCat7;
		7'd61: color = dogCat8;
		7'd62: color = dogCat9;
		7'd63: color = dogChicken1;
		7'd64: color = dogChicken2;
		7'd65: color = dogChicken3;
		7'd66: color = dogChicken4;
		7'd67: color = dogChicken5;
		7'd68: color = dogChicken6;
		7'd69: color = dogChicken7;
		7'd70: color = dogChicken8;
		7'd71: color = dogChicken9;
		7'd72: color = dogDog1;
		7'd73: color = dogDog2;
		7'd74: color = dogDog3;
		default: color = 3'b000;
	endcase
end

endmodule

module currentPlayerPoints(clk, playerReset, winner1, winner2, player1, player2, playerLoad);
input clk, playerReset, winner1, winner2, playerLoad;
output [3:0] player1, player2;
wire [3:0] player1ToUpdate, player2ToUpdate;

assign player1ToUpdate = winner1? player1+1: player1;
assign player2ToUpdate = winner2? player2+1: player2;

DFlipFlopEnable #(4) player1Reg(clk, player1ToUpdate, player1, playerReset, playerLoad);
DFlipFlopEnable #(4) player2Reg(clk, player2ToUpdate, player2, playerReset, playerLoad);

endmodule


