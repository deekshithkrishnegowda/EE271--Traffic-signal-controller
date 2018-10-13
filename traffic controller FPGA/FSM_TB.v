`timescale 10s/100ms
module traffic_controller_tb();

reg clock,reset,pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
				  	   pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input;
			 wire red_north,yellow_north,green_north,
				    red_west,yellow_west,green_west,
			            
				    red_north_one,yellow_north_one,green_north_one,
	    			    red_east_one,yellow_east_one,green_east_one;				 		
			 wire pedestrain_north,pedestrain_south,pedestrain_east,pedestrain_west,
		 		    pedestrain_north_one,pedestrain_south_one,pedestrain_east_one,pedestrain_west_one;

traffic_contoller DUT( clock,reset,pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
				  	   pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input,
			 red_north,yellow_north,green_north,
				    red_west,yellow_west,green_west,
			            
				    red_north_one,yellow_north_one,green_north_one,
	    			    red_east_one,yellow_east_one,green_east_one,				 		
			  pedestrain_north,pedestrain_south,pedestrain_east,pedestrain_west,
		 		    pedestrain_north_one,pedestrain_south_one,pedestrain_east_one,pedestrain_west_one );

always
begin
	clock=1'b0;
	#1;clock=1'b1;
	#1;
end




initial
begin
//	$dumpfile("traffic.vcd");
//	$dumpvars;
	@(negedge clock) reset=1;
	@(negedge clock) reset=0;
	{pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
	        pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input}={$random}%256;
	
	#140;
	$finish;
end
endmodule
