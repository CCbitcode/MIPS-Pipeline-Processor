module EX_MEM(
    input clk,reset,
    input [31 :0] EX_PCplus4     ,
    input [31 :0] ALU_out        ,
    input [4  :0] Write_register ,
    input [31 :0] EX_Databus2    ,
    //控制信号
    input EX_RegWrite            ,
    input EX_MemRead             ,
	input EX_MemWrite            ,
	input [2 -1:0] EX_MemtoReg   ,

    output reg [31 :0] MEM_PCplus4        ,
    output reg [31 :0] MEM_ALU_out        ,
    output reg [4  :0] MEM_Write_register ,
    output reg [31 :0] MEM_Databus2       ,
    //控制信号
    output reg MEM_RegWrite               ,
    output reg MEM_MemRead                ,
	output reg MEM_MemWrite               ,
	output reg [2 -1:0] MEM_MemtoReg   
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MEM_PCplus4 <= 32'h00000000;
            MEM_ALU_out <= 32'h00000000;
            MEM_Write_register <= 5'b00000;
            MEM_Databus2 <= 32'h00000000;
            // 控制信号复位
            MEM_RegWrite <= 1'b0;
            MEM_MemRead <= 1'b0;
            MEM_MemWrite <= 1'b0;
            MEM_MemtoReg <= 2'b00;
        end 
        else begin
            MEM_PCplus4 <= EX_PCplus4;
            MEM_ALU_out <= ALU_out;
            MEM_Write_register <= Write_register;
            MEM_Databus2 <= EX_Databus2;
            // 控制信号传递
            MEM_RegWrite <= EX_RegWrite;
            MEM_MemRead <= EX_MemRead;
            MEM_MemWrite <= EX_MemWrite;
            MEM_MemtoReg <= EX_MemtoReg;
        end
    end
endmodule