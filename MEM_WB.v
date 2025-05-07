module MEM_WB(
    input clk,reset,
    input [32 -1:0] MEM_PCplus4             ,
    input [32 -1:0] Memory_Read_Data        ,
    input [32 -1:0] MEM_ALU_out             ,
    input [4  :0] MEM_Write_register        ,
    input MEM_RegWrite                      ,
    input [2 -1:0] MEM_MemtoReg             ,
    output reg [32 -1:0] WB_PCplus4         ,
    output reg [32 -1:0] WB_Memory_Read_Data,
    output reg [32 -1:0] WB_ALU_out         ,
    output reg [4  :0] WB_Write_register    ,
    output reg WB_RegWrite                  ,
    output reg [2 -1:0] WB_MemtoReg
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            WB_PCplus4 <= 32'h00000000;
            WB_Memory_Read_Data <= 32'h00000000;
            WB_ALU_out <= 32'h00000000;
            WB_Write_register <= 5'b00000;
            WB_RegWrite <= 1'b0;
            WB_MemtoReg <= 2'b00;
        end 
        else begin
            WB_PCplus4 <= MEM_PCplus4;
            WB_Memory_Read_Data <= Memory_Read_Data;
            WB_ALU_out <= MEM_ALU_out;
            WB_Write_register <= MEM_Write_register;
            WB_RegWrite <= MEM_RegWrite;
            WB_MemtoReg <= MEM_MemtoReg;
        end
    end
endmodule
