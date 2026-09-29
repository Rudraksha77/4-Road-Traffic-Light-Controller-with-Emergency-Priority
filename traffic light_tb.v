`timescale 1ns/1ns
module traffic_light_controller_tb;
reg clk;
reg rst;

reg emergency_a;
reg emergency_b;
reg emergency_c;
reg emergency_d;

wire a_red;
wire a_yellow;
wire a_green;

wire b_red;
wire b_yellow;
wire b_green;

wire c_red;
wire c_yellow;
wire c_green;

wire d_red;
wire d_yellow;
wire d_green;


//====================================================
// DUT (design under test)
    
traffic_light_controller #(    //#(...) ka use parameter values override karne ke liye hua hai.
    .clk_frequency(5),       //"Is particular instance ke liye default parameter values use
                            //mat karo; meri di hui values use karo."
    .green_time  (2),
    .yellow_time(1)
 
 )inst_traffic_light_controller (
    .clk(clk),
    .rst(rst),

    .a_red(a_red),
    .a_yellow(a_yellow),
    .a_green(a_green),

    .b_red(b_red),
    .b_yellow(b_yellow),
    .b_green(b_green),
	
	.c_red(c_red),
    .c_yellow(c_yellow),
    .c_green(c_green),
	
	.d_red(d_red),
    .d_yellow(d_yellow),
    .d_green(d_green),
	
	.emergency_a(emergency_a),
    .emergency_b(emergency_b),
    .emergency_c(emergency_c),
    .emergency_d(emergency_d)
 );

//====================================================
// 50 MHz Clock
// Period = 20 ns
    
always #10 clk = ~clk;
  initial begin
     clk = 1'b0;
     rst = 1'b1;
     emergency_a=1'b0;
     emergency_b=1'b0;
     emergency_c=1'b0;
     emergency_d=1'b0;
    #20;
     rst = 1'b0;

    #100; 
     emergency_a = 1'b1;

    #20;
     emergency_a = 1'b0;

    #250;
     emergency_c = 1'b1;

    #20;
     emergency_c = 1'b0; 
    #250;

     rst = 1'b0;
    #60000;
    $finish;
  end

//====================================================
    
initial begin
  $monitor("TIME=%0t ns | STATE=%b | COUNT=%0d | a_RED=%b | a_YELLOW=%b | a_GREEN=%b | b_RED=%b | b_YELLOW=%b | b_GREEN=%b| c_RED=%b | c_YELLOW=%b | c_GREEN=%b | d_RED=%b | d_YELLOW=%b | d_GREEN=%b | EA=%b | EB=%b | EC=%b | ED=%b",
            $time,
            inst_traffic_light_controller.state,
            inst_traffic_light_controller.count,
            a_red,
            a_yellow,
            a_green,
            b_red,
            b_yellow,
            b_green,
			c_red,
            c_yellow,
            c_green,
			d_red,
            d_yellow,
            d_green,
			
			emergency_a,
            emergency_b,
            emergency_c,
            emergency_d
        );
    end
endmodule