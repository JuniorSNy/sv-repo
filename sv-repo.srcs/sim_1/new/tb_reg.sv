`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/17 00:17:07
// Design Name: 
// Module Name: tb_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_reg();

    logic clk;
    initial clk = 0;
    always #(10) clk = ~clk;
    
    integer cnt,cnt_t;
    initial cnt = 0;
    always @(posedge clk) begin 
        cnt <= cnt + 1; 
        cnt_t <= cnt;
        if(cnt < 32)begin
            cnt <= cnt + 2;
        end
    end
    
    always @(posedge clk) begin
        
    end

endmodule
