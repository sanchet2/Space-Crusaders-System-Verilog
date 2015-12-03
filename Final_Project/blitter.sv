module blitter(input Clk, Reset, new_sprite, valid,
					input [9:0] sprite_x_pos, sprite_y_pos,
					input [24:0] sprite_address,
					input [31:0] data_from_sdram,
					output wrote_sprite, read_req, write_req,
					output [31:0] data_out,
					output [24:0] address_to_sdram);
					
		enum logic [1:0] {WAIT, READ, WRITE} state, next_state;
		
		logic [11:0] counter;
		logic [31:0] data;
		
		always_ff @ (posedge Clk or posedge Reset)
		begin
				if(Reset)
				begin
						counter <= 12'b0;
						state <= WAIT;
						data <= 32'b0;
				end 
				else begin
						state <= next_state;
						unique case(state)
						WAIT: ;
						READ: begin
								data <= data_from_sdram;
						end 
						WRITE: begin
								if(valid)
									counter <= counter + 1'b1;
						end 
						endcase
				end 
		end 
		
		always_comb 
		begin
				wrote_sprite = 1'b0;
				read_req = 1'b0;
				write_req = 1'b0;
				data_out = 32'b0;
				address_to_sdram = 25'b0;
				
				unique case(state)
				WAIT: begin
						if(new_sprite)
							next_state = READ;
						else
							next_state = WAIT;
				end 
				READ: begin
						address_to_sdram = sprite_address + counter;
						read_req = 1'b1;
						if(valid)
							next_state = WRITE;
						else
							next_state = READ;
				end 
				WRITE: begin
						address_to_sdram = sprite_x_pos + counter%7'd64 + ((sprite_y_pos + counter/7'd64) * 10'd640);
						data_out = data;
						write_req = 1'b1;
						if(valid)
						begin
								if(counter >= 12'd4095)
								begin
										next_state = WAIT;
										wrote_sprite = 1'b1;
								end 
								else begin
										next_state = READ;
								end 
						end 
						else begin
								next_state = WRITE;
						end 
				end 
				endcase
				
				
		end 
					
					
endmodule 