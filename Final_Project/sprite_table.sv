module sprite_table(input Clk,
							input [5:0] in,
							output [44:0] out);
							
always @ (posedge Clk)
	case(in)
	6'd0: out <= {25'd307200, 10'd64, 10'd48}; // Player sprites
	6'd1: out <= {25'd310272, 10'd60, 10'd64};
	6'd2: out <= {25'd307200,10'd640,10'd480};
	6'd3: out <= {25'd320646, 10'd99, 10'd66}; // Enemy sprites //TODO: fix dimensions
	6'd4: out <= {25'd351834, 10'd226, 10'd138};
	6'd5: out <= {25'd357834, 10'd60, 10'd100};
	6'd6: out <= {25'd365952, 10'd123, 10'd66};
	6'd7: out <= {25'd373806, 10'd102, 10'd77};
	6'd8: out <= {25'd380176, 10'd98, 10'd65};
	6'd9: out <= {25'd386308, 10'd84, 10'd78};
	6'd10: out <= {25'd402200, 10'd116, 10'd137};
	6'd11: out <= {25'd408815, 10'd105, 10'd63};
	6'd12: out <= {25'd415490, 10'd89, 10'd75};

	endcase 
	
endmodule 