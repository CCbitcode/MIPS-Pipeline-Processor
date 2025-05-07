module test_cpu();
	
	reg reset   ;
	reg sysclk     ;

	//wire        MemRead             ; 
	//wire        MemWrite            ;
	//wire [31:0] MemBus_Address      ;
	//wire [31:0] MemBus_Write_Data   ;
	//wire [31:0] Device_Read_Data    ;
	
	CPU cpu1(  
		.reset              (reset              ), 
		.sysclk             (sysclk             )
		//.MemBus_Address     (MemBus_Address     ),
		//.Device_Read_Data   (Device_Read_Data   ), 
		//.MemBus_Write_Data  (MemBus_Write_Data  ), 
		//.MemRead            (MemRead            ), 
		//.MemWrite           (MemWrite           )
	);
	
	initial begin
		reset   = 1;
		sysclk     = 1;
		#100 reset = 0;
	end
	
	always #5 sysclk = ~sysclk;
		
endmodule
