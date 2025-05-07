module Forward(
    input [4  :0] EX_RegisterRs,
    input [4  :0] EX_RegisterRt,
    input MEM_RegWrite,
    input [4  :0] MEM_Write_register,
    input WB_RegWrite,
    input [4  :0]WB_Write_register,
    output reg [1  :0] ForwardA,
    output reg [1  :0] ForwardB
);

    initial begin
        ForwardA=2'b00;
        ForwardB=2'b00;
    end

    always @(*) begin
        //EX/MEM hazard
        if(MEM_RegWrite&&(MEM_Write_register!=0)&&(MEM_Write_register==EX_RegisterRs))
            ForwardA=2'b10;
        //MEM/WB hazard
        else if(WB_RegWrite&&(WB_Write_register!=0)&&(WB_Write_register==EX_RegisterRs)&&(MEM_Write_register!=EX_RegisterRs||~MEM_RegWrite))
            ForwardA=2'b01;
        else
            ForwardA=2'b00;

        //EX/MEM hazard
        if(MEM_RegWrite&&(MEM_Write_register!=0)&&(MEM_Write_register==EX_RegisterRt))
            ForwardB=2'b10; 
        //MEM/WB hazard
        else if(WB_RegWrite&&(WB_Write_register!=0)&&(WB_Write_register==EX_RegisterRt)&&(MEM_Write_register!=EX_RegisterRt||~MEM_RegWrite))
            ForwardB=2'b01;
        else
            ForwardB=2'b00;
    end

endmodule
