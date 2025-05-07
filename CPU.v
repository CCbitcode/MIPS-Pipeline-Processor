module CPU(
	input  reset,
	input  sysclk,
	output [7 :0] BCD,
	output [3 :0] ano                          
	//output MemRead                      , 
	//output MemWrite                     ,
	//output [32 -1:0] MemBus_Address     , 
	//output [32 -1:0] MemBus_Write_Data  , 
	//input  [32 -1:0] Device_Read_Data 
);
	
	wire clk;
	(* DONT_TOUCH = "yes" *)
	f_divider f_divider1(
		.sysclk  (sysclk 	),
    	.reset   (reset		),
    	.out_clk (clk		)
	); //50 MHz

	wire stall;
	wire IF_ID_flush;
	wire ID_EX_flush;
	wire [1  :0] ForwardA;
    wire [1  :0] ForwardB;

	// PC register
	reg  [31 :0] PC;
	wire [31 :0] PC_next;
	wire [31 :0] PC_plus_4;

	always @(posedge reset or posedge clk)
		if (reset)
			PC <= 32'h00000000;
		else if (stall)
			PC <= PC;
		else
			PC <= PC_next;
	
	assign PC_plus_4 = PC + 32'd4;
	
	// Instruction Memory
	wire [31 :0] Instruction;

	(* DONT_TOUCH = "yes" *)
	InstructionMemory instruction_memory1(
		.Address        (PC             ), 
		.Instruction    (Instruction    )
	);
	

	//IF/ID
	wire [31:0] ID_Instruction;
	wire [31:0] ID_PCplus4;

	(* DONT_TOUCH = "yes" *)
	IF_ID IF_ID1(
		.clk            (clk            ),
		.reset          (reset          ),
		.flush			(IF_ID_flush	),
		.stall			(stall			),
		.Instruction	(Instruction	),
		.PC_plus_4		(PC_plus_4		),
		.ID_Instruction	(ID_Instruction	),
		.ID_PCplus4		(ID_PCplus4		)
	);
    
	// Control 
	wire [2 -1:0] RegDst    ;
	wire [2 -1:0] PCSrc     ;
	wire [3 -1:0] Branch    ;//多种分支
	wire [2 -1:0] MemtoReg  ;
	wire          ALUSrc1   ;
	wire          ALUSrc2   ;
	wire [4 -1:0] ALUOp     ;
	wire          ExtOp     ;
	wire          LuOp      ;
	wire          RegWrite  ;

	
	(* DONT_TOUCH = "yes" *)
	Control control1(
		.OpCode     (ID_Instruction[31:26]  ), 
		.Funct      (ID_Instruction[5 : 0]  ),
		.PCSrc      (PCSrc                  ), 
		.Branch     (Branch             	), 
		.RegWrite   (RegWrite           	), 
		.RegDst     (RegDst             	), 
		.MemRead    (MemRead            	),	
		.MemWrite   (MemWrite           	), 
		.MemtoReg   (MemtoReg           	),
		.ALUSrc1    (ALUSrc1            	), 
		.ALUSrc2    (ALUSrc2            	), 
		.ExtOp      (ExtOp              	), 
		.LuOp       (LuOp               	),	
		.ALUOp      (ALUOp              	)
	);
	
	// Register File
	wire [32 -1:0] Databus1;
	wire [32 -1:0] Databus2; 
	wire [32 -1:0] Databus3;
	//wire [5  -1:0] Write_register;

	//assign Write_register = (RegDst == 2'b00)? ID_Instruction[20:16]: (RegDst == 2'b01)? ID_Instruction[15:11]: 5'b11111;//WB

    wire WB_RegWrite				  ;
	wire [4  :0] WB_Write_register	  ;

	(* DONT_TOUCH = "yes" *)
	RegisterFile register_file1(				
		.reset          (reset              	), 
		.clk            (clk                	),
		.RegWrite       (WB_RegWrite           	),
		.Read_register1 (ID_Instruction[25:21] 	), 
		.Read_register2 (ID_Instruction[20:16] 	), 
		.Write_register (WB_Write_register     	),
		.Write_data     (Databus3           	),
		.Read_data1     (Databus1           	), 
		.Read_data2     (Databus2           	)
	);

	// Extend
	wire [32 -1:0] Ext_out;
	assign Ext_out = { ExtOp? {16{ID_Instruction[15]}}: 16'h0000, ID_Instruction[15:0]};
	wire [32 -1:0] LU_out;
	assign LU_out = LuOp? {ID_Instruction[15:0], 16'h0000}: Ext_out;
	

	//ID/EX
	wire [31 :0] EX_PCplus4   ;
    wire [31 :0] EX_Databus1  ;
    wire [31 :0] EX_Databus2  ;
    wire [31 :0] EX_LU_out    ;
    wire [4  :0] EX_RegisterRs;
    wire [4  :0] EX_RegisterRt;
	wire [4  :0] EX_RegisterRd;
	wire [5  :0] EX_Funct	  ;
	wire [4  :0] EX_Shamt	  ;

    wire [2 -1:0] EX_PCSrc    ;
	wire [3 -1:0] EX_Branch   ;
	wire EX_RegWrite          ;
	wire [2 -1:0] EX_RegDst   ;
	wire EX_MemRead           ;
	wire EX_MemWrite          ;
	wire [2 -1:0] EX_MemtoReg ;
	wire EX_ALUSrc1           ;
	wire EX_ALUSrc2           ;
	wire [4 -1:0] EX_ALUOp    ;

	(* DONT_TOUCH = "yes" *)
	ID_EX ID_EX1(
		.clk			(clk					),
		.reset			(reset					),
		.flush			(ID_EX_flush			),
		.stall			(stall					),
		.ID_PCplus4		(ID_PCplus4				),
		.Databus1		(Databus1				),
		.Databus2		(Databus2				),
		.LU_out			(LU_out					),
		.ID_RegisterRs	(ID_Instruction[25:21]	),
		.ID_RegisterRt	(ID_Instruction[20:16]	),
		.ID_RegisterRd	(ID_Instruction[15:11]	),
		.Funct			(ID_Instruction[5:0]	),
		.Shamt			(ID_Instruction[10:6]	),
		//控制信号输入
		.PCSrc      (PCSrc                  ), 
		.Branch     (Branch             	), 
		.RegWrite   (RegWrite           	), 
		.RegDst     (RegDst             	), 
		.MemRead    (MemRead            	),	
		.MemWrite   (MemWrite           	), 
		.MemtoReg   (MemtoReg           	),
		.ALUSrc1    (ALUSrc1            	), 
		.ALUSrc2    (ALUSrc2            	), 
		.ALUOp      (ALUOp              	),

    	.EX_PCplus4		(EX_PCplus4    	),
    	.EX_Databus1 	(EX_Databus1	),
    	.EX_Databus2 	(EX_Databus2	),
    	.EX_LU_out   	(EX_LU_out		),
    	.EX_RegisterRs	(EX_RegisterRs	),
    	.EX_RegisterRt	(EX_RegisterRt	),
		.EX_RegisterRd	(EX_RegisterRd	),
		.EX_Funct		(EX_Funct		),  
		.EX_Shamt		(EX_Shamt		),  
		//控制信号输出
		.EX_PCSrc    (EX_PCSrc              ), 
		.EX_Branch   (EX_Branch            	), 
		.EX_RegWrite (EX_RegWrite           ), 
		.EX_RegDst   (EX_RegDst             ), 
		.EX_MemRead  (EX_MemRead            ),	
		.EX_MemWrite (EX_MemWrite           ), 
		.EX_MemtoReg (EX_MemtoReg           ),
		.EX_ALUSrc1  (EX_ALUSrc1            ), 
		.EX_ALUSrc2  (EX_ALUSrc2            ), 
		.EX_ALUOp    (EX_ALUOp              )  
	);

	
	// ALU Control
	wire [5 -1:0] ALUCtl;
	wire          Sign  ; 

	(* DONT_TOUCH = "yes" *)
	ALUControl alu_control1(
		.ALUOp  (EX_ALUOp           ), 
		.Funct  (EX_Funct  			), 
		.ALUCtl (ALUCtl             ), 
		.Sign   (Sign               )
	);
		
	// ALU
	wire [32 -1:0] ALU_in1		;
	wire [32 -1:0] ALU_in2		;
	wire [32 -1:0] ALU_out		;
	wire           Zero   		;
	wire		   LTZero   	;
	wire [31 :0]   MEM_Databus2	;
	wire [31 :0] MEM_ALU_out    ;
	wire [32 -1:0] DatabusA  	;
	wire [32 -1:0] DatabusB  	;
	assign DatabusA = (ForwardA == 2'b10)?MEM_ALU_out:
	     	          (ForwardA == 2'b01)?Databus3:
					  EX_Databus1;
	assign ALU_in1 = EX_ALUSrc1? {27'h00000, EX_Shamt}: DatabusA;//移位量或Rs
	assign DatabusB = (ForwardB == 2'b10)?MEM_ALU_out:
	     	          (ForwardB == 2'b01)?Databus3:
					  EX_Databus2;
	assign ALU_in2 = EX_ALUSrc2? EX_LU_out: DatabusB;//立即数或Rt

	(* DONT_TOUCH = "yes" *)
	ALU alu1(
		.in1    (ALU_in1    ), 
		.in2    (ALU_in2    ), 
		.ALUCtl (ALUCtl     ), 
		.Sign   (Sign       ), 
		.out    (ALU_out    ), 
		.zero   (Zero       ),
		.LTZero	(LTZero		)
	);

	wire [5  -1:0] Write_register;
	assign Write_register = (EX_RegDst == 2'b00)? EX_RegisterRt: 
							(EX_RegDst == 2'b01)? EX_RegisterRd: 
							5'b11111;	
		
	//执行分支判断

	//EX/MEM
	wire [31 :0] MEM_PCplus4        ;
    wire [4  :0] MEM_Write_register ;
    wire MEM_RegWrite         		;
    wire MEM_MemRead            	;
	wire MEM_MemWrite            	;
	wire [2 -1:0] MEM_MemtoReg 		;

	(* DONT_TOUCH = "yes" *)
	EX_MEM EX_MEM1(
		.clk				(clk				),
		.reset				(reset				),
		.EX_PCplus4			(EX_PCplus4			),
     	.ALU_out			(ALU_out			),
     	.Write_register		(Write_register		),
      	.EX_Databus2		(DatabusB		    ),
		.EX_RegWrite		(EX_RegWrite		),
     	.EX_MemRead			(EX_MemRead			),
	 	.EX_MemWrite		(EX_MemWrite		),
	 	.EX_MemtoReg		(EX_MemtoReg		),
		.MEM_PCplus4		(MEM_PCplus4		),
       	.MEM_ALU_out		(MEM_ALU_out		),
      	.MEM_Write_register (MEM_Write_register ),
		.MEM_Databus2		(MEM_Databus2		),
		.MEM_RegWrite		(MEM_RegWrite		),
		.MEM_MemRead		(MEM_MemRead		),
	  	.MEM_MemWrite		(MEM_MemWrite		),
	   	.MEM_MemtoReg		(MEM_MemtoReg		) 
	);

	// Data Memory
	wire [32 -1:0] Memory_Read_Data ;
	//wire [32 -1:0] MemBus_Read_Data ;

	(* DONT_TOUCH = "yes" *)
	DataMemory data_memory1(
		.reset      (reset              ), 
		.clk        (clk                ), 
		.Address    (MEM_ALU_out     	), 
		.Write_data (MEM_Databus2  		), 
		.Read_data  (Memory_Read_Data   ), 
		.MemRead    (MEM_MemRead        ), 
		.MemWrite   (MEM_MemWrite       ),
		.BCD   		(BCD				),
		.ano		(ano				)
	);
	//assign MemBus_Address       = MEM_ALU_out ;
	//assign MemBus_Write_Data    = Databus2;
	//assign MemBus_Read_Data     = Memory_Read_Data;//DataMemory output
	
	//MEM/WB
	wire [32 -1:0] WB_PCplus4         ;
	wire [32 -1:0] WB_Memory_Read_Data;
	wire [32 -1:0] WB_ALU_out         ;


    wire [2 -1:0] WB_MemtoReg         ;

	(* DONT_TOUCH = "yes" *)
	MEM_WB MEM_WB1(
		.clk				(clk				),
		.reset				(reset				),
		.MEM_PCplus4		(MEM_PCplus4		),
      	.Memory_Read_Data	(Memory_Read_Data	),
		.MEM_ALU_out		(MEM_ALU_out		),
      	.MEM_Write_register	(MEM_Write_register	),
     	.MEM_RegWrite		(MEM_RegWrite		),
      	.MEM_MemtoReg		(MEM_MemtoReg		),
		.WB_PCplus4			(WB_PCplus4			),
       	.WB_Memory_Read_Data(WB_Memory_Read_Data),
		.WB_ALU_out		 	(WB_ALU_out			),
       	.WB_Write_register	(WB_Write_register	),
      	.WB_RegWrite		(WB_RegWrite		),
       	.WB_MemtoReg		(WB_MemtoReg		)
	);

	// write back
	assign Databus3 = (WB_MemtoReg == 2'b00)? WB_ALU_out: (WB_MemtoReg == 2'b01)? WB_Memory_Read_Data: WB_PCplus4;
	
	
	// PC jump and branch
	wire [32 -1:0] Jump_target;
	assign Jump_target = {ID_PCplus4[31:28], ID_Instruction[25:0], 2'b00};
	
	wire [32 -1:0] Branch_target;
	assign Branch_target =
	(((EX_Branch==3'b001)&    Zero) || //beq
	 ((EX_Branch==3'b010)&  (~Zero))|| //bne
	 ((EX_Branch==3'b011)&  LTZero) || //bltz 
	 ((EX_Branch==3'b100)& (  Zero  || LTZero))|| //blez
	 ((EX_Branch==3'b101)&((~LTZero)&& (~Zero))))? EX_PCplus4 + {EX_LU_out[29:0], 2'b00}: //bgtz
	PC_plus_4; 
	
	assign PC_next = ((EX_PCSrc == 2'b00&&(EX_Branch & Zero))||(PCSrc == 2'b00))? Branch_target: (PCSrc == 2'b01)? Jump_target: Databus1;

	//flush
	assign IF_ID_flush = 
	((PCSrc == 2'b01)||                //j
	 ((EX_Branch==3'b001)&    Zero) || //beq
	 ((EX_Branch==3'b010)&  (~Zero))|| //bne
	 ((EX_Branch==3'b011)&  LTZero) || //bltz 
	 ((EX_Branch==3'b100)& (  Zero  || LTZero))|| //blez
	 ((EX_Branch==3'b101)&((~LTZero)&& (~Zero))))? 1'b1: 1'b0;
	assign ID_EX_flush = 
	(((EX_Branch==3'b001)&    Zero) || //beq
	 ((EX_Branch==3'b010)&  (~Zero))|| //bne
	 ((EX_Branch==3'b011)&  LTZero) || //bltz 
	 ((EX_Branch==3'b100)& (  Zero  || LTZero))|| //blez
	 ((EX_Branch==3'b101)&((~LTZero)&& (~Zero))))? 1'b1: 1'b0;

	//Foward
	(* DONT_TOUCH = "yes" *)
	Forward Forward1(
		.EX_RegisterRs		(EX_RegisterRs		),
		.EX_RegisterRt		(EX_RegisterRt		),
		.MEM_RegWrite		(MEM_RegWrite		),
		.MEM_Write_register	(MEM_Write_register	),
		.WB_RegWrite		(WB_RegWrite		),
		.WB_Write_register	(WB_Write_register	),
		.ForwardA			(ForwardA			),
		.ForwardB			(ForwardB			)
	);

	(* DONT_TOUCH = "yes" *)
	Hazard Hazard1(
		.ID_registerRs (ID_Instruction[25:21] 	), 
		.ID_registerRt (ID_Instruction[20:16] 	), 
		.Write_register(Write_register			),
		.EX_MemRead	   (EX_MemRead				),
		.stall         (stall					)
	);
	

endmodule
