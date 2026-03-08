module EC61_TB();
reg clk, rst, up, down;
    wire gnd, mv;  
    wire [1:0] dir; 
    wire [2:0] count;
    reg [1:0] state; // Idle (00), Running (01)
	EC61( clk, rst, up, down,gnd, mv,count,dir);
initial
begin
clk = 0;
rst = 1'b1;
#10
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#10
clk = 0;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#20
clk = 1;
rst = 1'b0;
up = 1'b1;
down = 1'b0;
#40
clk = 0;
rst = 1'b0;
up = 1'b1;
down = 1'b0;
#60
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b1;
#80
clk = 0;
rst = 1'b0;
up = 1'b0;
down = 1'b1;
#100
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#120
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#140
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#160
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#180
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
#200
clk = 1;
rst = 1'b0;
up = 1'b0;
down = 1'b0;
end
endmodule
