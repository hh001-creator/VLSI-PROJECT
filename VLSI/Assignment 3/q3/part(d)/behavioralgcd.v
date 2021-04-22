module GCD_behavioral #(parameter W = 16)
(
    input [W - 1:0] AR , BR,
    output[W - 1:0] out
);
    reg [W - 1:0] A , B , out , swap;
    always @(*) begin
        A = AR; B = BR;
        while (B != 0) begin
            if(A < B) begin
                swap = A;
                A = B;
                B = swap;
            end
               A = A - B;
        end
        out = A;
    end
    
endmodule
