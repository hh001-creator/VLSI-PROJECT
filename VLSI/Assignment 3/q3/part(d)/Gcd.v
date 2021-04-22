module GCD (
    input clk ,
    input [5:0] A , B,
    input reset,
    output reg [5:0] C
);
    output reg [1:0] present , next;
    reg K1 , K2 , subract , swap , selectxy , loadxr , loadyr , AR, BR , temp;
    
    parameter S0 = 00,
              S1 = 01,
              S2 = 10,
              S3 = 11;
    always @(posedge clk) begin
        if(reset == 1) begin
            present <= S0;
        end
        else begin
            present <= next;
        end
    end

    always @(present, K1 , K2) begin
        next = S0;
        case(present)
            S0: begin
                if(K1 == 0)
                    next = S3;
                else if((K1 == 1) && (K2 == 1)) begin
                    next = S2;
                end
                else
                    next = S1; 
            end
            S1 : begin
                next = S2;
            end
            S2 : begin
                if(K1 == 0)
                    next = S3;
                else if((K1 == 1) && (K2 == 1))
                    next = S2;
                else
                    next = S1;
            end
            S3 : begin
                next = S3;
            end    
        endcase
        //$monitor("%d , %d",present , next);
    end
    always @(*) begin
        subract = (present == S2) ? 1 : 0;
        swap = (present == S1) ? 1 : 0;
        selectxy = (present == S0) ? 1 : 0;
        loadxr = ((present == S0) | (present == S1) | (present == S2)) ? 1 : 0;
        loadyr = ((present == S0) | (present == S1)) ? 1 : 0;
        K1 = (AR > 0) ? 1 : 0;
        K2 = (AR > BR) ? 1 : 0;
    end
    always @(present , K1 , K2) begin
        case(present)
            S0: begin
                AR = A;
                BR = B;
                //$monitor("%d , %d",AR , BR);
            end
            S1: begin
                temp = AR;
                AR = BR;
                BR = temp;
            end
            S2: begin
                AR = AR - BR;
                C = AR;
                $monitor("%d , %d , %d",AR , BR , C);
            end
        endcase
    end
endmodule