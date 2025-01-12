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
    reg [7:0] expected_seven_segment_data;
    reg [3:0] expected_seven_segment_enable;
    reg test_passed;

    // Expected values for ASCII to 7-segment mapping (example, should be replaced with actual mapping)
    function [7:0] ascii_to_7seg_data;
        input [7:0] ascii;
        case (ascii)
            8'd48: ascii_to_7seg_data = 8'b11000000; // '0'
            8'd49: ascii_to_7seg_data = 8'b11111001; // '1'
            8'd50: ascii_to_7seg_data = 8'b10100100; // '2'
            8'd51: ascii_to_7seg_data = 8'b10110000; // '3'
            8'd52: ascii_to_7seg_data = 8'b10011001; // '4'
            8'd53: ascii_to_7seg_data = 8'b10010010; // '5'
            8'd54: ascii_to_7seg_data = 8'b10000010; // '6'
            8'd55: ascii_to_7seg_data = 8'b11111000; // '7'
            8'd56: ascii_to_7seg_data = 8'b10000000; // '8'
            8'd57: ascii_to_7seg_data = 8'b10010000; // '9'
            8'd65: ascii_to_7seg_data = 8'b10001000; // 'A'
            8'd66: ascii_to_7seg_data = 8'b10000011; // 'B'
            8'd67: ascii_to_7seg_data = 8'b11000110; // 'C'
            8'd68: ascii_to_7seg_data = 8'b10100001; // 'D'
            8'd69: ascii_to_7seg_data = 8'b10000110; // 'E'
            8'd70: ascii_to_7seg_data = 8'b10001110; // 'F'
            default: ascii_to_7seg_data = 8'b11111111; // Invalid input
        endcase
    endfunction

    function [3:0] ascii_to_7seg_enable;
        input [7:0] ascii;
        if ((ascii >= 8'd48 && ascii <= 8'd57) || (ascii >= 8'd65 && ascii <= 8'd70))
            ascii_to_7seg_enable = 4'b1110; // Example enable pattern
        else
            ascii_to_7seg_enable = 4'b0000; // Invalid input
    endfunction

    initial begin
        ascii_data = 8'd0;
        data_valid = 1'b0;
        test_passed = 1'b1;

        $display("Starting Testbench...");
        $monitor("Time: %0t | ASCII Data: %h | Data Valid: %b | 7-Segment Data: %b | Enable: %b | Expected Data: %b | Expected Enable: %b", 
                 $time, ascii_data, data_valid, seven_segment_data, seven_segment_enable, expected_seven_segment_data, expected_seven_segment_enable);

        // Test valid ASCII range: '0'-'9'
        $display("Testing valid ASCII range: '0'-'9'");
        for (i = 48; i <= 57; i = i + 1) begin
            #5;
            ascii_data = i;
            data_valid = 1'b1;
            expected_seven_segment_data = ascii_to_7seg_data(i);
            expected_seven_segment_enable = ascii_to_7seg_enable(i);
            #5;
            data_valid = 1'b0;

            if (seven_segment_data !== expected_seven_segment_data || seven_segment_enable !== expected_seven_segment_enable) begin
                $display("FAIL: ASCII %h | Expected: %b, %b | Got: %b, %b", ascii_data, expected_seven_segment_data, expected_seven_segment_enable, seven_segment_data, seven_segment_enable);
                test_passed = 1'b0;
            end
        end

        // Test valid ASCII range: 'A'-'F'
        $display("Testing valid ASCII range: 'A'-'F'");
        for (i = 65; i <= 70; i = i + 1) begin
            #5;
            ascii_data = i;
            data_valid = 1'b1;
            expected_seven_segment_data = ascii_to_7seg_data(i);
            expected_seven_segment_enable = ascii_to_7seg_enable(i);
            #5;
            data_valid = 1'b0;

            if (seven_segment_data !== expected_seven_segment_data || seven_segment_enable !== expected_seven_segment_enable) begin
                $display("FAIL: ASCII %h | Expected: %b, %b | Got: %b, %b", ascii_data, expected_seven_segment_data, expected_seven_segment_enable, seven_segment_data, seven_segment_enable);
                test_passed = 1'b0;
            end
        end

        #10;
        if (test_passed) $display("All tests PASSED.");
        else $display("Some tests FAILED.");

        $stop;
    end

endmodule


//直接顯示比對結果
