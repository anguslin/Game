
//The starting point of the xcoordinate
//module xInitReg (clk, xInitReset, xInitSel, xInit, xInitLoad);
//input clk, xInitReset, xInitLoad;
//input [4:0] xInitSel;
//output [7:0] xInit;
//wire [7:0] xInitToUpdate;

//assign xInitToUpdate = 1'b0;

//DFlipFlopEnable #(8) xInitReg(clk, xInitToUpdate, xInit, xInitReset, xInitLoad);
//endmodule

//The starting point of the ycoordinate

//module yInitReg (clk, yInitReset, yInitSel, yInit, yInitLoad);
//input clk, yInitReset, yInitLoad;
//input [1:0] yInitSel;
//output [6:0] yInit;
//reg [6:0] yInitToUpdate;

//always @ (*) begin
//	case(yInitSel)
//		2'b00: yInitToUpdate = 7'd0; //For Starting at the top left corner
//		2'b01: yInitToUpdate = 7'd30; //Height for the battles
//		default: yInitToUpdate = 7'b0;
//	endcase
//end
//DFlipFlopEnable #(7) yInitReg(clk, yInitToUpdate, yInit, yInitReset, yInitLoad);
//endmodule


//The actual x and y coordinates

module xyReg(clk, xReset, yReset, xySel, x, y, xLoad, yLoad, xStart, yStart, xCountUp, yCountUp, screenDone);
input clk, xCountUp, xReset, xLoad, xStart, yCountUp, yReset, yLoad, yStart;
input [1:0] xySel;
//input [7:0] xInit;
//input [6:0] yInit;
output reg screenDone;
output [7:0] x; 
output [6:0] y;
reg [7:0] xToUpdate;
reg [6:0] yToUpdate;

always@(*) begin
	case(xySel)
		2'b00: begin
			yToUpdate = 0;
			xToUpdate = 0;
		end
		2'b01: begin //Whole Screen Reading
		       if (y < 120 && x == 160 && yCountUp) begin
					yToUpdate = y + 1;
					xToUpdate = 1;
			end else if (x < 160 && xCountUp) begin
					xToUpdate = x + 1;
					end 
		end	
	endcase
end

DFlipFlopEnable #(8) xReg(clk, xToUpdate, x, xReset, xLoad);
DFlipFlopEnable #(7) yReg(clk, yToUpdate, y, yReset, yLoad);

endmodule


//10 from title screens, 4 from chicken, 6 from dog, 12 from cat -> 10+4+6+12=32
module color(clk, black, memorySel, title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, catCat2, catCat3, catChicken5, catChicken6, catChicken7, catChicken8, catChicken9, catDog5, catDog6, catDog7, catDog8, catDog9, dogDog2, dogDog3, dogCat5, dogCat6, dogCat7, dogCat8, dogCat9, dogChicken5, dogChicken6, dogChicken7, dogChicken8, dogChicken9, chickenChicken2, chickenChicken3, chickenDog4, chickenDog5, chickenDog6, chickenDog7, chickenDog8, chickenDog9, chickenCat4, chickenCat5, chickenCat6, chickenCat7, chickenCat8, chickenCat9, color);

input clk, black; //black is same as Reset, except 000 corresponds to black
input [2:0] title1, title2, title3, choose1, choose2, choose3, p1Win1, p1Win2, p2Win1, p2Win2, catCat2, catCat3, catChicken5, catChicken6, catChicken7, catChicken8, catChicken9, catDog5, catDog6, catDog7, catDog8, catDog9, dogDog2, dogDog3, dogCat5, dogCat6, dogCat7, dogCat8, dogCat9, dogChicken5, dogChicken6, dogChicken7, dogChicken8, dogChicken9, chickenChicken2, chickenChicken3, chickenDog5, chickenDog6, chickenDog7, chickenDog8, chickenDog9, chickenCat5, chickenCat6, chickenCat7, chickenCat8, chickenCat9;

input [6:0] memorySel;
output reg [2:0] color;

always @(*) begin
	casex({black,memorySel}) //Does not rely on clk to update
	{1'b1,7'bxxxxxxx}: color = 3'b000;
	{1'b0,7'd0 }: color = title1;
	{1'b0,7'd1 }: color = title2;
	{1'b0,7'd2 }: color = title3;
	{1'b0,7'd3 }: color = choose1;
	{1'b0,7'd4 }: color = choose2;
	{1'b0,7'd5 }: color = choose3;
	{1'b0,7'd6 }: color = p1Win1;
	{1'b0,7'd7 }: color = p1Win2;
	{1'b0,7'd8 }: color = p2Win2;
	{1'b0,7'd9 }: color = p2Win2;
//	{1'b0,7'd10}: color = catCat1; 
	{1'b0,7'd11}: color = catCat2;
	{1'b0,7'd12}: color = catCat3;
//	{1'b0,7'd13}: color = catDog1;
//	{1'b0,7'd14}: color = catDog2;       
//	{1'b0,7'd15}: color = catDog3;      
//	{1'b0,7'd16}: color = catDog4;
	{1'b0,7'd17}: color = catDog5;
	{1'b0,7'd18}: color = catDog6;
	{1'b0,7'd19}: color = catDog7;
	{1'b0,7'd20}: color = catDog8;
	{1'b0,7'd21}: color = catDog9;
//	{1'b0,7'd22}: color = catChicken1;
//	{1'b0,7'd23}: color = catChicken2; 
//	{1'b0,7'd24}: color = catChicken3;  
//	{1'b0,7'd25}: color = catChicken4;
	{1'b0,7'd26}: color = catChicken5;
	{1'b0,7'd27}: color = catChicken6;
	{1'b0,7'd28}: color = catChicken7;
	{1'b0,7'd29}: color = catChicken8;
	{1'b0,7'd30}: color = catChicken9;
//	{1'b0,7'd31}: color = chickenCat1;
//	{1'b0,7'd32}: color = chickenCat2;
//	{1'b0,7'd33}: color = chickenCat3;
//	{1'b0,7'd34}: color = chickenCat4;
	{1'b0,7'd35}: color = chickenCat5;
	{1'b0,7'd36}: color = chickenCat6;
	{1'b0,7'd37}: color = chickenCat7;
	{1'b0,7'd38}: color = chickenCat8;
	{1'b0,7'd39}: color = chickenCat9;
//	{1'b0,7'd40}: color = chickenChicken3; 
	{1'b0,7'd41}: color = chickenChicken2;
	{1'b0,7'd42}: color = chickenChicken3;
//	{1'b0,7'd43}: color = chickenDog1; 
//	{1'b0,7'd44}: color = chickenDog2;
//	{1'b0,7'd45}: color = chickenDog3;
//	{1'b0,7'd46}: color = chickenDog4;
	{1'b0,7'd47}: color = chickenDog5;
	{1'b0,7'd48}: color = chickenDog6;
	{1'b0,7'd49}: color = chickenDog7;
	{1'b0,7'd50}: color = chickenDog8;
	{1'b0,7'd51}: color = chickenDog9;
//	{1'b0,7'd52}: color = dogCat1; 
//	{1'b0,7'd53}: color = dogCat2; 
//	{1'b0,7'd54}: color = dogCat3;
//	{1'b0,7'd55}: color = dogCat4;
	{1'b0,7'd56}: color = dogCat5;
	{1'b0,7'd57}: color = dogCat6;
	{1'b0,7'd58}: color = dogCat7;
	{1'b0,7'd59}: color = dogCat8;
	{1'b0,7'd60}: color = dogCat9;
//	{1'b0,7'd61}: color = dogChicken1;
//	{1'b0,7'd62}: color = dogChicken2;
//	{1'b0,7'd63}: color = dogChicken3;
//	{1'b0,7'd64}: color = dogChicken4;
	{1'b0,7'd65}: color = dogChicken5;
	{1'b0,7'd66}: color = dogChicken6;
	{1'b0,7'd67}: color = dogChicken7;
	{1'b0,7'd68}: color = dogChicken8;
	{1'b0,7'd69}: color = dogChicken9;
//	{1'b0,7'd70}: color = dogDog3;
	{1'b0,7'd71}: color = dogDog2;
	{1'b0,7'd72}: color = dogDog3;
	default: color = 3'b000;
	endcase
end

endmodule

module currentPlayerPoints(clk, playerReset, winner1, winner2, player1, player2, playerLoad);
input clk, playerReset, winner1, winner2, playerLoad;
output [3:0] player1, player2;
wire [3:0] player1ToUpdate, player2ToUpdate;

assign player1ToUpdate = player1+1;
assign player2ToUpdate = player2+1;

DFlipFlopEnable #(4) player1Reg(clk, player1ToUpdate, player1, playerReset, winner1);
DFlipFlopEnable #(4) player2Reg(clk, player2ToUpdate, player2, playerReset, winner2);

endmodule

