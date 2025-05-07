module DataMemory(
	input  reset    , 
	input  clk      ,  
	input  MemRead  ,
	input  MemWrite ,
	input  [32 -1:0] Address    ,
	input  [32 -1:0] Write_data ,
	output [32 -1:0] Read_data	,
	output [7    :0] BCD		,
	output [3    :0] ano
);
	
	// RAM size is 256 words, each word is 32 bits, valid address is 8 bits
	parameter RAM_SIZE      = 256;
	parameter RAM_SIZE_BIT  = 8;
	
	// RAM_data is an array of 256 32-bit registers
	reg [31:0] RAM_data [RAM_SIZE - 1: 0];

	reg [31:0] Output_RAM_data;

	// read data from RAM_data as Read_data
	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	assign ano = Output_RAM_data[11:8];
	assign BCD = Output_RAM_data[7 :0];


	// write Write_data to RAM_data at clock posedge
	integer i;
	always @(posedge reset or posedge clk)begin
		if (reset) begin
			// -------- Paste Data Memory Configuration Below (Data-q1.txt)
			RAM_data[0] <= 32'd20;
            RAM_data[1] <= 32'd16808;
            RAM_data[2] <= 32'd15090;
            RAM_data[3] <= 32'd44250;
            RAM_data[4] <= 32'd3115;
            RAM_data[5] <= 32'd46979;
            RAM_data[6] <= 32'd56009;
            RAM_data[7] <= 32'd36569;
            RAM_data[8] <= 32'd2559;
            RAM_data[9] <= 32'd12100;
            RAM_data[10] <= 32'd1102;
            RAM_data[11] <= 32'd39065;
            RAM_data[12] <= 32'd15446;
            RAM_data[13] <= 32'd4749;
            RAM_data[14] <= 32'd56291;
            RAM_data[15] <= 32'd54452;
            RAM_data[16] <= 32'd14152;
            RAM_data[17] <= 32'd14616;
            RAM_data[18] <= 32'd16658;
            RAM_data[19] <= 32'd50073;
            RAM_data[20] <= 32'd18773;

			for (i = 21; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;

			Output_RAM_data <= 32'h00000000;
			// -------- Paste Data Memory Configuration Above
		end
		else if (MemWrite) begin
			if(Address==32'h40000010) begin
				Output_RAM_data <= Write_data;
			end
			else begin
				RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			end		
		end
	end
			
endmodule


         
