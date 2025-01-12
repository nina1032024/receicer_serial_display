`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/08 16:49:49
// Design Name: 
// Module Name: test_serial_display
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


`timescale 1ns/1ps

module test_serial_display();

    reg [7:0] ascii_data;               
    reg data_valid;                     
    wire [7:0] seven_segment_data;      
    wire [3:0] seven_segment_enable;    

    serial_display uut (
        .ascii_data(ascii_data),
        .data_valid(data_valid),
        .seven_segment_data(seven_segment_data),
        .seven_segment_enable(seven_segment_enable)
    );
    
    integer i;
    initial begin
 
        ascii_data = 8'd0;
        data_valid = 1'b0;
        
        $display("Starting Testbench...");
        //不知道是不是再對的時間出來
        $monitor("Time: %0t | ASCII Data: %h | Data Valid: %b | 7-Segment Data: %b | Enable: %b", 
                 $time, ascii_data, data_valid, seven_segment_data, seven_segment_enable);

        $display("Testing valid ASCII range: '0'-'9'");
        for (i = 48; i <= 57; i = i + 1) begin
            #5;                     
            ascii_data = i;       
            data_valid = 1'b1;      
            #5 data_valid = 1'b0;    
        end

        $display("Testing valid ASCII range: 'A'-'F'");
        for (i = 65; i <= 70; i = i + 1) begin
            #5;
            ascii_data = i;
            data_valid = 1'b1;
            #5 data_valid = 1'b0;
        end

        #10;
        $display("Testbench completed.");
        $stop;
    end

endmodule

//直接顯示比對結果
