`timescale 1s/1ms
module traffic_controller_tb();

reg clock,reset,pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
	        pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input; 

wire red_north,yellow_north,green_north,
     red_east,yellow_east,green_east,
     red_west,yellow_west,green_west,
     red_north_one,yellow_north_one,green_north_one,
     red_east_one,yellow_east_one,green_east_one,
     red_west_one,yellow_west_one,green_west_one,	

     pedestrain_north,pedestrain_south,pedestrain_east,pedestrain_west,
     pedestrain_north_one,pedestrain_south_one,pedestrain_east_one,pedestrain_west_one;

traffic_contoller DUT(clock,reset,pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
				  	   pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input,
			 red_north,yellow_north,green_north,
			 red_east,yellow_east,green_east,
			 red_west,yellow_west,green_west,
			            
			red_north_one,yellow_north_one,green_north_one,
	    	        red_east_one,yellow_east_one,green_east_one,
		        red_west_one,yellow_west_one,green_west_one,		
			
			pedestrain_north,pedestrain_south,pedestrain_east,pedestrain_west,
		        pedestrain_north_one,pedestrain_south_one,pedestrain_east_one,pedestrain_west_one );

always
begin
	clock=1'b0;
	#1;clock=1'b1;
	#1;
end

/*initial
	begin
	$monitor($time,,,"NORTH red_north<=%d,yellow_north=%d,green_north=%d",red_north,yellow_north,green_north);	
	end

initial 
	begin
	$monitor($time,,,"WEST  red_west<=%d,yellow_west=%d,green_west=%d",red_west,yellow_west,green_west);

	end
initial
	begin
	$monitor($time,,,"EAST  red_east<=%d,yellow_east=%d,green_east=%d",red_east,yellow_east,green_east);

	end
initial
	begin
	$monitor($time,,,"SOUTH red_south<=%d,yellow_south=%d,green_south=%d",red_south,yellow_south,green_south);

	end*/


initial
begin
	$dumpfile("traffic.vcd");
	$dumpvars;
	@(negedge clock) reset=1;
	@(negedge clock) reset=0;
	{pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
	        pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input}={$random}%256;
	
	#140;
	$finish;
end
endmodule
