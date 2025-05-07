module Hazard(
    input [4  :0] ID_registerRs, 
	input [4  :0] ID_registerRt, 
    input [4  :0] Write_register,
    input EX_MemRead,  

    output reg stall
);


//load-use hazard
    always @(*)begin
        if(EX_MemRead&&((Write_register==ID_registerRs)||(Write_register==ID_registerRt)))
            stall<=1'b1;    
        else
            stall<=1'b0;
    end

endmodule