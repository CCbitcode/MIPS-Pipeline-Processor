module InstructionMemory(
	input      [32 -1:0] Address, 
	output reg [32 -1:0] Instruction
);
	
	always @(*)
		case (Address[9:2])

			// -------- Paste Binary Instruction Below (Inst-q1-1/Inst-q1-2.txt)

			8'd0:   Instruction <= 32'h20100000;
			8'd1:   Instruction <= 32'h200a0004;
			8'd2:   Instruction <= 32'h8e110000;
			8'd3:   Instruction <= 32'h222cffff;
			8'd4:   Instruction <= 32'h00117021;
			8'd5:   Instruction <= 32'h22100004;
			8'd6:   Instruction <= 32'h22100004;
			8'd7:   Instruction <= 32'h21520000;
			8'd8:   Instruction <= 32'h21530004;
			8'd9:   Instruction <= 32'h8e080000;
			8'd10:  Instruction <= 32'h22100004;
			8'd11:  Instruction <= 32'h8d490000;
			8'd12:  Instruction <= 32'h0109082a;
			8'd13:  Instruction <= 32'h14200005;
			8'd14:  Instruction <= 32'h214a0004;
			8'd15:  Instruction <= 32'had480000;
			8'd16:  Instruction <= 32'h226a0000;
			8'd17:  Instruction <= 32'h22730004;
			8'd18:  Instruction <= 32'h08100017;
			8'd19:  Instruction <= 32'had490004;
			8'd20:  Instruction <= 32'h124afffa;
			8'd21:  Instruction <= 32'h214afffc;
			8'd22:  Instruction <= 32'h0810000b;
			8'd23:  Instruction <= 32'h218cffff;
			8'd24:  Instruction <= 32'h1580fff0;
			8'd25:  Instruction <= 32'h20040064;
			8'd26:  Instruction <= 32'h2005003f;
			8'd27:  Instruction <= 32'hac850000;
			8'd28:  Instruction <= 32'h20050006;
			8'd29:  Instruction <= 32'hac850004;
			8'd30:  Instruction <= 32'h2005005b;
			8'd31:  Instruction <= 32'hac850008;
			8'd32:  Instruction <= 32'h2005004f;
			8'd33:  Instruction <= 32'hac85000c;
			8'd34:  Instruction <= 32'h20050066;
			8'd35:  Instruction <= 32'hac850010;
			8'd36:  Instruction <= 32'h2005006d;
			8'd37:  Instruction <= 32'hac850014;
			8'd38:  Instruction <= 32'h2005007d;
			8'd39:  Instruction <= 32'hac850018;
			8'd40:  Instruction <= 32'h20050007;
			8'd41:  Instruction <= 32'hac85001c;
			8'd42:  Instruction <= 32'h2005007f;
			8'd43:  Instruction <= 32'hac850020;
			8'd44:  Instruction <= 32'h2005006f;
			8'd45:  Instruction <= 32'hac850024;
			8'd46:  Instruction <= 32'h20050077;
			8'd47:  Instruction <= 32'hac850028;
			8'd48:  Instruction <= 32'h2005007c;
			8'd49:  Instruction <= 32'hac85002c;
			8'd50:  Instruction <= 32'h20050039;
			8'd51:  Instruction <= 32'hac850030;
			8'd52:  Instruction <= 32'h2005005e;
			8'd53:  Instruction <= 32'hac850034;
			8'd54:  Instruction <= 32'h20050079;
			8'd55:  Instruction <= 32'hac850038;
			8'd56:  Instruction <= 32'h20050071;
			8'd57:  Instruction <= 32'hac85003c;
			8'd58:  Instruction <= 32'h20080000;
			8'd59:  Instruction <= 32'h3c0d4000;
			8'd60:  Instruction <= 32'h21ad0010;
			8'd61:  Instruction <= 32'h21080004;
			8'd62:  Instruction <= 32'h201200fa;
			8'd63:  Instruction <= 32'h8d090000;
			8'd64:  Instruction <= 32'h00095302;
			8'd65:  Instruction <= 32'h000a5080;
			8'd66:  Instruction <= 32'h01445820;
			8'd67:  Instruction <= 32'h8d6c0000;
			8'd68:  Instruction <= 32'h218c0800;
			8'd69:  Instruction <= 32'hadac0000;
			8'd70:  Instruction <= 32'h21ef30d4;
			8'd71:  Instruction <= 32'h21efffff;
			8'd72:  Instruction <= 32'h15e0fffe;
			8'd73:  Instruction <= 32'h00095500;
			8'd74:  Instruction <= 32'h000a5702;
			8'd75:  Instruction <= 32'h000a5080;
			8'd76:  Instruction <= 32'h01445820;
			8'd77:  Instruction <= 32'h8d6c0000;
			8'd78:  Instruction <= 32'h218c0400;
			8'd79:  Instruction <= 32'hadac0000;
			8'd80:  Instruction <= 32'h21ef30d4;
			8'd81:  Instruction <= 32'h21efffff;
			8'd82:  Instruction <= 32'h15e0fffe;
			8'd83:  Instruction <= 32'h00095600;
			8'd84:  Instruction <= 32'h000a5702;
			8'd85:  Instruction <= 32'h000a5080;
			8'd86:  Instruction <= 32'h01445820;
			8'd87:  Instruction <= 32'h8d6c0000;
			8'd88:  Instruction <= 32'h218c0200;
			8'd89:  Instruction <= 32'hadac0000;
			8'd90:  Instruction <= 32'h21ef30d4;
			8'd91:  Instruction <= 32'h21efffff;
			8'd92:  Instruction <= 32'h15e0fffe;
			8'd93:  Instruction <= 32'h00095700;
			8'd94:  Instruction <= 32'h000a5702;
			8'd95:  Instruction <= 32'h000a5080;
			8'd96:  Instruction <= 32'h01445820;
			8'd97:  Instruction <= 32'h8d6c0000;
			8'd98:  Instruction <= 32'h218c0100;
			8'd99:  Instruction <= 32'hadac0000;
			8'd100: Instruction <= 32'h21ef30d4;
			8'd101: Instruction <= 32'h21efffff;
			8'd102: Instruction <= 32'h15e0fffe;
			8'd103: Instruction <= 32'h2252ffff;
			8'd104: Instruction <= 32'h1640ffd6;
			8'd105: Instruction <= 32'h21ceffff;
			8'd106: Instruction <= 32'h15c0ffd2;





			// 8'd0:	Instruction <= 32'h20042f5b;
			// 8'd1:	Instruction <= 32'h2405cfc7;
			// 8'd2:	Instruction <= 32'h00053400;
			// 8'd3:	Instruction <= 32'h00063c03;
			// 8'd4:	Instruction <= 32'hac040000;
			// 8'd5:	Instruction <= 32'h10e50001;
			// 8'd6:	Instruction <= 32'h3c0456ce;
			// 8'd7:	Instruction <= 32'h00c44020;
			// 8'd8:	Instruction <= 32'h00084a03;
			// 8'd9:	Instruction <= 32'h200ad0a5;
			// 8'd10:	Instruction <= 32'h008a102a;
			// 8'd11:	Instruction <= 32'h008a182b;
			// 8'd12:	Instruction <= 32'h8c0b0000;
			// 8'd13:	Instruction <= 32'h0810000d;
			

			// -------- Paste Binary Instruction Above
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule



