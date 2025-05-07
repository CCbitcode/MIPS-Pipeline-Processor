module ID_EX(
    input clk,reset,flush,stall,
    input [31 :0] ID_PCplus4,
    input [31 :0] Databus1,
    input [31 :0] Databus2,
    input [31 :0] LU_out,
    input [4  :0] ID_RegisterRs,
    input [4  :0] ID_RegisterRt,
    input [4  :0] ID_RegisterRd,
    input [5  :0] Funct,
    input [4  :0] Shamt,
    //控制信号输入
    input [2 -1:0] PCSrc    ,
	input [3 -1:0] Branch   ,
	input RegWrite          ,
	input [2 -1:0] RegDst   ,
	input MemRead           ,
	input MemWrite          ,
	input [2 -1:0] MemtoReg ,
	input ALUSrc1           ,
	input ALUSrc2           ,
	input [4 -1:0] ALUOp    ,
    

    output reg [31 :0] EX_PCplus4   ,
    output reg [31 :0] EX_Databus1  ,
    output reg [31 :0] EX_Databus2  ,
    output reg [31 :0] EX_LU_out    ,
    output reg [4  :0] EX_RegisterRs,
    output reg [4  :0] EX_RegisterRt,
    output reg [4  :0] EX_RegisterRd,
    output reg [5  :0] EX_Funct     ,
    output reg [4  :0] EX_Shamt     ,
    //控制信号输出
    output reg [2 -1:0] EX_PCSrc    ,
	output reg [3 -1:0] EX_Branch   ,
	output reg EX_RegWrite          ,
	output reg [2 -1:0] EX_RegDst   ,
	output reg EX_MemRead           ,
	output reg EX_MemWrite          ,
	output reg [2 -1:0] EX_MemtoReg ,
	output reg EX_ALUSrc1           ,
	output reg EX_ALUSrc2           ,
	output reg [4 -1:0] EX_ALUOp    
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            EX_PCplus4 <= 32'h00000000;
            EX_Databus1 <= 32'h00000000;
            EX_Databus2 <= 32'h00000000;
            EX_LU_out <= 32'h00000000;
            EX_RegisterRs <= 5'b00000;
            EX_RegisterRt <= 5'b00000;
            EX_RegisterRd <= 5'b00000;
            EX_Funct <= 6'b000000;
            EX_Shamt <= 5'b00000;
            // 控制信号复位
            EX_PCSrc <= 2'b00;
            EX_Branch <= 3'b000;
            EX_RegWrite <= 1'b0;
            EX_RegDst <= 2'b00;
            EX_MemRead <= 1'b0;
            EX_MemWrite <= 1'b0;
            EX_MemtoReg <= 2'b00;
            EX_ALUSrc1 <= 1'b0;
            EX_ALUSrc2 <= 1'b0;
            EX_ALUOp <= 4'b0000;
        end 
        else if(flush) begin
            EX_PCplus4 <= 32'h00000000;
            EX_Databus1 <= 32'h00000000;
            EX_Databus2 <= 32'h00000000;
            EX_LU_out <= 32'h00000000;
            EX_RegisterRs <= 5'b00000;
            EX_RegisterRt <= 5'b00000;
            EX_RegisterRd <= 5'b00000;
            EX_Funct <= 6'b000000;
            EX_Shamt <= 5'b00000;
            EX_PCSrc <= 2'b00;
            EX_Branch <= 3'b000;
            EX_RegWrite <= 1'b0;
            EX_RegDst <= 2'b00;
            EX_MemRead <= 1'b0;
            EX_MemWrite <= 1'b0;
            EX_MemtoReg <= 2'b00;
            EX_ALUSrc1 <= 1'b0;
            EX_ALUSrc2 <= 1'b0;
            EX_ALUOp <= 4'b0000;
        end
        else if(stall) begin
            EX_RegWrite <= 1'b0;
            EX_MemRead <= 1'b0;
            EX_MemWrite <= 1'b0;
        end
        else begin
            EX_PCplus4 <= ID_PCplus4;
            EX_Databus1 <= Databus1;
            EX_Databus2 <= Databus2;
            EX_LU_out <= LU_out;
            EX_RegisterRs <= ID_RegisterRs;
            EX_RegisterRt <= ID_RegisterRt;
            EX_RegisterRd <= ID_RegisterRd;
            EX_Funct <= Funct;
            EX_Shamt <= Shamt;
            // 控制信号传递
            EX_PCSrc <= PCSrc;
            EX_Branch <= Branch;
            EX_RegWrite <= RegWrite;
            EX_RegDst <= RegDst;
            EX_MemRead <= MemRead;
            EX_MemWrite <= MemWrite;
            EX_MemtoReg <= MemtoReg;
            EX_ALUSrc1 <= ALUSrc1;
            EX_ALUSrc2 <= ALUSrc2;
            EX_ALUOp <= ALUOp;
        end
    end

endmodule