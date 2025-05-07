module f_divider( 
    input sysclk,
    input reset,
    output reg out_clk
);  
    //reg  cnt;  
    always @( posedge sysclk or posedge reset) begin 
        if(reset) begin
            //cnt <= 1'b0; 
            out_clk <= 1'b0;
        end
        else begin 
            //cnt <= (cnt==1'd1) ? 1'd0 : cnt + 1'd1;  
            //out_clk <= (cnt==1'd0) ? ~out_clk : out_clk; 
            out_clk <= ~out_clk; 
        end  
    end
endmodule