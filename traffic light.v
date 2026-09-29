module traffic_light_controller(
    input clk,
    input rst,
	
	input emergency_a,
    input emergency_b,
    input emergency_c,
    input emergency_d,
 

    output reg a_red,
    output reg a_yellow,
    output reg a_green,

    output reg b_red,
    output reg b_yellow,
    output reg b_green,

    output reg c_red,
    output reg c_yellow,
    output reg c_green,

    output reg d_red,
    output reg d_yellow,
    output reg d_green
);
    
	// Clock frequency
parameter clk_frequency = 50;
    // Timing

parameter yellow_time   = 3;
parameter green_time    = 10;
//"I used parameters so that timing can be changed easily without modifying 
    //the main logic.
   
 // State declaration   
reg [3:0] state;

//"I used parameters so that timing can be changed easily without modifying 
    //the main logic. reg [3:0] state;

parameter S0 = 4'b0000;  // A+B GREEN
parameter S1 = 4'b0001;  // A+B YELLOW
parameter S2 = 4'b0010;  // C+D GREEN
parameter S3 = 4'b0011;  // C+D YELLOW

// Emergency states
parameter S4 = 4'b0100;  // A emergency
parameter S5 = 4'b0101;  // B emergency
parameter S6 = 4'b0110;  // C emergency
parameter S7 = 4'b0111;  // D emergency

    // Counter
reg [31:0] count;

//====================================================
// STATE TRANSITION

// Counter + State Machine
    //yahi counter time measure karne ke liye use hota hai.

always @(posedge clk or posedge rst)
begin
    if (rst)  //Agar rst = 1 hai, to reset karo.and show s0
    begin
        state <= S0;
        count <= 0;
    end
	
    else
	if (emergency_a)
    begin
        state <= S4;
        count <= 0;
    end

    else if (emergency_b)
    begin
        state <= S5;
        count <= 0;
    end

    else if (emergency_c)
    begin
        state <= S6;
        count <= 0;
    end

    else if (emergency_d)
    begin
        state <= S7;
        count <= 0;
    end

    //========================================
    // NORMAL TRAFFIC
    //========================================

    else

    begin    //Agar reset active nahi hai, tab normal operation karo.
        case (state)       //case state check Abhi FSM kis state mein hai?

            // S0 = A GREEN
     // A Green for 10 seconds
	// S0: A Green Timing
	
       // CLK_FREQ = 50, GREEN_TIME = 10
      // Total cycles = 50 × 10 = 500
     // Counter starts from 0, so last count = 499
    // When count == 499, A Green time is complete
            // S0 = A/B GREEN, C/D RED
            
            S0:
            begin
                if (count == (clk_frequency * green_time) - 1)
                begin
                    count <= 0;    //Counter ko dobara zero karo.
                    state <= S1;    //S0 se S1 mein jao.
                end
                else
                begin     //Agar required time complete nahi hua, counter ko 1 se increase karo.
                    count <= count + 1'b1;
                end
            end

            //========================================
            // S1 = A/B YELLOW, C/D RED
            
            S1:
            begin
                if (count == (clk_frequency * yellow_time) - 1)
                begin
                    count <= 0;
                    state <= S2;
                end
                else
                begin
                    count <= count + 1'b1;
                end
            end

            //========================================
            // S2 = A/B RED, C/D GREEN

            S2:
            begin
                if (count == (clk_frequency * green_time) - 1)
                begin
                    count <= 0;
                    state <= S3;
                end
                else
                begin
                    count <= count + 1'b1;
                end
            end

            //========================================
            // S3 = A/B RED, C/D YELLOW

            S3:
            begin
                if (count == (clk_frequency * yellow_time) - 1)
                begin
                    count <= 0;
                    state <= S0;
                end
                else
                begin
                    count <= count + 1'b1;
                end
            end
			
			S4:
begin
    if (count == (clk_frequency * green_time) - 1)
    begin
        count <= 0;
        state <= S0;
    end
    else
    begin
        count <= count + 1'b1;
    end
end

S5:
begin
    if (count == (clk_frequency * green_time) - 1)
    begin
        count <= 0;
        state <= S0;
    end
    else
    begin
        count <= count + 1'b1;
    end
end

S6:
begin
    if (count == (clk_frequency * green_time) - 1)
    begin
        count <= 0;
        state <= S2;
    end
    else
    begin
        count <= count + 1'b1;
    end
end

S7:
begin
    if (count == (clk_frequency * green_time) - 1)
    begin
        count <= 0;
        state <= S2;
    end
    else
    begin
        count <= count + 1'b1;
    end
end

             //========================================
            // DEFAULT
            
            default:
            begin
                state <= S0;
                count <= 0;
            end

        endcase
    end
end


//====================================================
// OUTPUT LOGIC
//====================================================

always @(state )   //Is block mein jo signals use hue hain, unmein koi bhi change ho, 
                 // to block dobara execute karo.
begin

    // Default OFF
    a_red    = 1'b0;
    a_yellow = 1'b0;
    a_green  = 1'b0;

    b_red    = 1'b0;
    b_yellow = 1'b0;
    b_green  = 1'b0;

    c_red    = 1'b0;
    c_yellow = 1'b0;
    c_green  = 1'b0;

    d_red    = 1'b0;
    d_yellow = 1'b0;
    d_green  = 1'b0;

    case (state)

        //============================================
        // S0
        // A/B GREEN
        // C/D RED
        
        S0:
        begin
            a_green = 1'b1;
            b_green = 1'b1;

            c_red = 1'b1;
            d_red = 1'b1;
        end

        //============================================
        // S1
        // A/B YELLOW
        // C/D RED
        
        S1:
        begin
            a_yellow = 1'b1;
            b_yellow = 1'b1;

            c_red = 1'b1;
            d_red = 1'b1;
        end

        //============================================
        // S2
        // A/B RED
        // C/D GREEN
        
        S2:
        begin
            a_red = 1'b1;
            b_red = 1'b1;

            c_green = 1'b1;
            d_green = 1'b1;
        end

        //============================================
        // S3
        // A/B RED
        // C/D YELLOW
        
        S3:
        begin
            a_red = 1'b1;
            b_red = 1'b1;

            c_yellow = 1'b1;
            d_yellow = 1'b1;
        end
		
		        //============================================
        // EMERGENCY A
        // A GREEN, B/C/D RED

        S4:
        begin
            a_green = 1'b1;

            b_red = 1'b1;
            c_red = 1'b1;
            d_red = 1'b1;
        end


        //============================================
        // EMERGENCY B
        // B GREEN, A/C/D RED

        S5:
        begin
            a_red = 1'b1;

            b_green = 1'b1;

            c_red = 1'b1;
            d_red = 1'b1;
        end


        //============================================
        // EMERGENCY C
        // C GREEN, A/B/D RED

        S6:
        begin
            a_red = 1'b1;
            b_red = 1'b1;

            c_green = 1'b1;

            d_red = 1'b1;
        end


        //============================================
        // EMERGENCY D
        // D GREEN, A/B/C RED

        S7:
        begin
            a_red = 1'b1;
            b_red = 1'b1;
            c_red = 1'b1;

            d_green = 1'b1;
        end

        //============================================
        // DEFAULT
        // ALL RED
        
        default:
        begin
            a_red = 1'b1;
            b_red = 1'b1;
            c_red = 1'b1;
            d_red = 1'b1;
        end

    endcase
end

endmodule