

module EC61( clk, rst, up, down,gnd, mv,count,dir);
input clk, rst, up, down;
    output reg gnd, mv;  
    output reg [1:0] dir; 
    output reg [2:0] count;
    reg [1:0] state; // Idle (00), Running (01)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            count <= 3'b000;
            gnd <= 1;  // Lift is at Ground Floor 
            mv <= 0;   // Lift is not moving
            dir <= 2'b01; // Default direction UP
        end else begin
            case (state)
                2'b00: begin  // Idle State
                    if (count >= 3'b101) begin
                        // If idle for more than 5 cycles, return to Ground Floor
                        gnd <= 1;
                        mv <= 1;
                        dir <= 2'b10; // Move DOWN to ground
                        state <= 2'b01; // Change to Running
                    end else if (up) begin
                        // Up request received
                        mv <= 1;
                        dir <= 2'b01; // Move UP
                        state <= 2'b01;
                    end else if (down) begin
                        // Down request received
                        mv <= 1;
                        dir <= 2'b10; // Move DOWN
                        state <= 2'b01;
                    end else begin
                        count <= count + 1;
                    end
                end

                2'b01: begin  // Running State
                    if (up && dir == 2'b10) begin
                        // If moving DOWN but an UP request is closer, stop
                        dir <= 2'b01;
                        mv <= 1;
                    end else if (down && dir == 2'b01) begin
                        // If moving UP but a DOWN request is closer, stop
                        dir <= 2'b10;
                        mv <= 1;
                    end else if ((!up && dir == 2'b01) || (!down && dir == 2'b10)) begin
                        // Stop at destination
                        mv <= 0;
                        state <= 2'b00; // Change back to Idle
                        count <= 0;  // Reset Idle counter
                    end
                end

                default: begin
                    state <= 2'b00;
                    dir <= 2'b01;
                    gnd <= 0;
                    mv <= 0;
                end
            endcase
        end
    end
endmodule
