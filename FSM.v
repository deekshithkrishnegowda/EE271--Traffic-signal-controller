`timescale 1s/1ms

module traffic_contoller(input clock,reset,pedestrain_north_input, pedestrain_south_input,pedestrain_east_input,pedestrain_west_input, 
				  	   pedestrain_north_one_input, pedestrain_south_one_input,pedestrain_east_one_input,pedestrain_west_one_input,
			 output reg red_north,yellow_north,green_north,
			           /* red_south,yellow_south,green_south,*/
				    red_east,yellow_east,green_east,
				    red_west,yellow_west,green_west,
			            
				    red_north_one,yellow_north_one,green_north_one,
	    			    red_east_one,yellow_east_one,green_east_one,
				    red_west_one,yellow_west_one,green_west_one,		
			 output reg pedestrain_north,pedestrain_south,pedestrain_east,pedestrain_west,
		 		    pedestrain_north_one,pedestrain_south_one,pedestrain_east_one,pedestrain_west_one);

parameter state_north=2'b00,
	  state_east=2'b10,
	  state_west=2'b01;

reg [1:0] ns,ps; //next_state and present_state
reg [3:0] count_north,count_east,count_west;
reg [2:0] count_north_one;/*count_east_one,count_west_one*/
reg temp;


/////////////////////////////////////////////////////////////////counter_logic///////////////////////////////////////////
always@(posedge clock)
begin
	if(reset)
		begin
		count_north<=0;count_east<=0;count_west<=0;
		count_north_one<=0;
		end
	
	else if (count_north==15||count_west==15||count_east==15)
		begin
		count_north<=0;count_east<=0;count_west<=0;
		end
/*	else if(count_north_one==7)
		begin
		count_north_one<=0;count_east_one<=0;count_west_one<=0;
		end*/
	else
		begin
		case (ps)
		state_north:	begin
					count_north<=count_north+1'b1;
					if(count_north>=5 && count_north<=12)
					                   count_north_one<=count_north_one+1'b1;
					else		   
							   count_north_one<=0;
								
					
				end
		state_west:	begin
					count_west<=count_west+1'b1;
				/*	if(count_west>=5) count_west_one<=count_west_one+1'b1;
					else		  count_west_one<=0;*/

				end
		state_east:	begin
					count_east<=count_east+1'b1;
				/*	if(count_east>=5) count_east_one<=count_east_one+1'b1;
					else		  count_east_one<=0;*/

				end
		endcase
		end
end


/////////////////////////////////////////////////////////present_state/////////////////////////////////////////
always@(posedge clock) 
begin
	if(reset)
		ps<=state_north;	
	else
	begin
		ps<=ns;
	end
end



//////////////////////////////////////////////////////////////next_state///////////////////////////////////////
always@(*)   
begin
	case(ps)
	state_north:if(count_north==15) ns=state_west;
		    else ns=state_north;
	state_west: if(count_west==15) ns=state_east;
		    else ns=state_west;
	state_east: if(count_east==15) ns=state_north;
		    else ns=state_east;
	default: ns=state_north;
	endcase
end



/////////////////////////////////////////////////////////////////output_logic///////////////////////////////////////
always@(posedge clock)
begin
	if(reset)
		begin
				red_north<=0;yellow_north<=0;green_north<=0;
				red_east<=0;yellow_east<=0;green_east<=0;
				red_west<=0;yellow_west<=0;green_west<=0;
				
				red_north_one<=0;yellow_north_one<=0;green_north_one<=0;
				red_east_one<=0;yellow_east_one<=0;green_east_one<=0;
				red_west_one<=0;yellow_west_one<=0;green_west_one<=0;

				pedestrain_north<=0;pedestrain_south<=0;pedestrain_east<=0;pedestrain_west<=0;
				pedestrain_north_one<=0;pedestrain_south_one<=0;pedestrain_east_one<=0;pedestrain_west_one<=0;
		end
	else
	begin	
	case(ps)
		state_north:
		begin
		    red_north<=1;red_east<=1;red_west<=1;
		    yellow_north<=0;yellow_east<=0;yellow_west<=0;
		    green_north<=0;green_east<=0;green_west<=0;

		    red_north_one<=1;yellow_north_one<=0;green_north_one<=0;
		    red_east_one<=1;yellow_east_one<=0;green_east_one<=0;
		    red_west_one<=1;yellow_west_one<=0;green_west_one<=0;

		  		 if(count_north>=0&&count_north<=2) 
				 	begin 
			   		red_north<=1;yellow_north<=0;green_north<=0;
					red_north_one<=1;yellow_north_one<=0;green_north_one<=0;
					end
				 else
					temp<=1'bz;
				 if(count_north>=2&&count_north<=4)
					begin
					red_north<=0;yellow_north<=1;green_north<=0;
					end
				 else
					temp<=1'bz;
				if(count_north>=4 && count_north<=11)
					begin
					green_north<=1;yellow_north<=0;red_north<=0;
					end
					else
						temp<=1'bz;
				if(count_north>=11 && count_north<=13)
					begin
					green_north<=0;yellow_north<=1;red_north<=0;
					end
				else
					temp<=1'bz;
				if(count_north>=13 && count_north<=15)
					begin
					yellow_north<=0;red_north<=1;green_north<=0;
					red_north_one<=1;
					end
				else
					temp<=1'bz;
				
				if(red_west && pedestrain_west_input && green_north ) //pedestrain crossing 
					begin
					pedestrain_west<=1;
				        end
				else
					pedestrain_west<=0;
				
				if(red_east && pedestrain_east_input && green_north )
					begin
					pedestrain_east<=1;
					end
				else
					pedestrain_east<=0;


				if(red_west_one && pedestrain_west_one_input && green_north_one ) //pedestrain crossing 
					begin
					pedestrain_west_one<=1;
				        end
				else
					pedestrain_west_one<=0;
				
				if(red_east_one && pedestrain_east_one_input && green_north_one )
					begin
					pedestrain_east_one<=1;
					end
				else
					pedestrain_east_one<=0;


				if(count_north>=5 && count_north<=12)
				begin
					if(count_north_one>=0 && count_north_one<2)
						begin
						red_north_one<=0;yellow_north_one<=1;green_north_one<=0;
						end
					else
					        temp<=1'bz;					
					
					if(count_north_one>=2 && count_north_one<5)
						begin
						red_north_one<=0;yellow_north_one<=0;green_north_one<=1;
						end
					else
						temp<=1'bz;
					
					if(count_north_one>=5 && count_north_one<7)
						begin
						red_north_one<=0;yellow_north_one<=1;green_north_one<=0;
						end
					else
						temp<=1'bz;
				end
				else
					temp<=1'bz;
				


		end
		
		state_west:
		begin
		 red_north<=1;red_east<=1;red_west<=1;
		 yellow_north<=0;yellow_east<=0;yellow_west<=0;
		 green_north<=0;green_east<=0;green_west<=0;

		 red_north_one<=1;yellow_north_one<=0;green_north_one<=0;
		 red_east_one<=1;yellow_east_one<=0;green_east_one<=0;
		 red_west_one<=1;yellow_west_one<=0;green_west_one<=0;


		  		 if(count_west>=0&&count_west<=2) 
				 	begin 
			   		red_west<=1;yellow_west<=0;green_west<=0;
					red_west_one<=1;yellow_west_one<=0;green_west_one<=0;
			   		end
				 else
					temp<=1'bz;
				 if(count_west>=2&&count_west<=4)
					begin
					red_west<=0;yellow_west<=1;green_west<=0;
					red_west_one<=0;yellow_west_one<=1;green_west_one<=0;
					end
				 else
					temp<=1'bz;
				if(count_west>=4 && count_west<=11)
					begin
					green_west<=1;yellow_west<=0;red_west<=0;
					red_west_one<=0;yellow_west_one<=0;green_west_one<=1;
					end
					else
						temp<=1'bz;
				if(count_west>=11 && count_west<=13)
					begin
					green_west<=0;yellow_west<=1;red_west<=0;
					red_west_one<=0;yellow_west_one<=1;green_west_one<=0;
					end
				else
					temp<=1'bz;
				if(count_west>=13 && count_west<=15)
					begin
					yellow_west<=0;red_west<=1;green_west<=0;
					red_west_one<=1;yellow_west_one<=0;green_west_one<=0;
					end
				else
					temp<=1'bz;

				if(red_north && pedestrain_north_input && green_west)	//pedestrain crossing 
					pedestrain_north<=1;
				else
					pedestrain_north<=0;
				
				if(red_north && pedestrain_south_input && green_west)
					pedestrain_south<=1;
				else
					pedestrain_south<=0;

				if(red_north_one && pedestrain_north_one_input && green_west_one)	//pedestrain crossing 
					pedestrain_north_one<=1;
				else
					pedestrain_north_one<=0;
				
				if(red_north_one && pedestrain_south_one_input && green_west_one)
					pedestrain_south_one<=1;
				else
					pedestrain_south_one<=0;


		
         	end

	
		state_east:
		begin
		    red_north<=1;red_east<=1;red_west<=1;
		    yellow_north<=0;yellow_east<=0;yellow_west<=0;
		    green_north<=0;green_east<=0;green_west<=0;

		 red_north_one<=1;yellow_north_one<=0;green_north_one<=0;
		 red_east_one<=1;yellow_east_one<=0;green_east_one<=0;
		 red_west_one<=1;yellow_west_one<=0;green_west_one<=0;

		  		 if(count_east>=0&&count_east<=2) 
				 	begin 
			   		red_east<=1;yellow_east<=0;green_east<=0;
					red_east_one<=1;yellow_east_one<=0;green_east_one<=0;

			   		end
				 else
					temp<=1'bz;
				 if(count_east>=2&&count_east<=4)
					begin
					red_east<=0;yellow_east<=1;green_east<=0;
					red_east_one<=0;yellow_east_one<=1;green_east_one<=0;

					end
				 else
					temp<=1'bz;
				if(count_east>=4 && count_east<=11)
					begin
					green_east<=1;yellow_east<=0;red_east<=0;
				        red_east_one<=0;yellow_east_one<=0;green_east_one<=1;

					end
					else
						temp<=1'bz;
				if(count_east>=11 && count_east<=13)
					begin
					green_east<=0;yellow_east<=1;red_east<=0;
					 red_east_one<=0;yellow_east_one<=1;green_east_one<=0;
					end
				else
					temp<=1'bz;
				if(count_east>=13 && count_east<=15)
					begin
					yellow_east<=0;red_east<=1;green_east<=0;
				        red_east_one<=1;yellow_east_one<=0;green_east_one<=0;

					end
				else
					temp<=1'bz;
				if(red_north && pedestrain_north_input && green_east) //pedestrain crossing 
					pedestrain_north<=1;
				else
					pedestrain_north<=0;
				
				if(red_north && pedestrain_south_input && green_east)
					pedestrain_south<=1;
				else
					pedestrain_south<=0;

				if(red_north_one && pedestrain_north_one_input && green_east_one) //pedestrain crossing 
					pedestrain_north_one<=1;
				else
					pedestrain_north_one<=0;
				
				if(red_north && pedestrain_south_one_input && green_east_one)
					pedestrain_south_one<=1;
				else
					pedestrain_south_one<=0;


  
		end
	endcase
	end
end

endmodule



	       			       




