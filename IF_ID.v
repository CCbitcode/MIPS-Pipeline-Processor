module IF_ID(
    input clk,reset,flush,stall,
    input [31 :0] Instruction,
    input [31 :0] PC_plus_4,
    output reg [31 :0] ID_Instruction,
    output reg [31 :0] ID_PCplus4
);

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            ID_Instruction<=32'b0;
            ID_PCplus4<=32'b0;
        end
        else if(flush) begin
            ID_Instruction<=32'b0;
            ID_PCplus4<=32'b0;
        end
        else if(stall) begin
            ID_Instruction<=ID_Instruction;
            ID_PCplus4<=ID_PCplus4;
        end
        else begin
            ID_Instruction<=Instruction;
            ID_PCplus4<=PC_plus_4;
        end
    end


endmodule