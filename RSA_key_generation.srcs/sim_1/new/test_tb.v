`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2025 22:22:54
// Design Name: 
// Module Name: test_tb
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


module test_tb();
    reg clk=0,start=1;
    reg[1:0] sel_8;
    reg[2:0] sel_16;
    wire[15:0] private_key,public_key;
    
    rsa_key_gen dut(clk,start,sel_8,sel_16,private_key,public_key);
    
    
    always
        #1 clk=~clk;
        
    initial
            begin
                sel_8=1;
                sel_16=2;
            end
endmodule
