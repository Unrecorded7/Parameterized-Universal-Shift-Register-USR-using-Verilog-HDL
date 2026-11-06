module top#(
    parameter width =8 
) (
    input lin,
    input rin,
    input clk,
    input lr,
    input clr,
    input en,
    input hold,
    input load,
    input [width-1:0] p_load,
    output reg [width-1:0]q
);
generate
    if(width==1)begin
        always @(posedge clk) begin
            if (clr)
                q <= 1'b0;
            else if(load)
                q <= p_load;
            else if(en&&!hold) begin
            if (lr)
                q <= rin;
            else
                q <= lin;
            end
        end
            end
      
    
    else begin

    always @(posedge clk) begin
        if(clr)
        q<=0;
        else if(load)
            q<=p_load;
        else if(en&& !hold) begin
        
            case (lr)
            1'b0:q<={q[width-2:0],lin};
            1'b1:q<={rin,q[width-1:1]};
        endcase
        end
    end 
end

endgenerate

endmodule