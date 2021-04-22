module ControlUnit(
    input K1 , K2 , clk , reset,
    output reg subract = 0 ,
    output reg swap = 0 , 
    output reg selectxy = 0 , 
    output loadxr = 0 , 
    output loadyr = 0,
    output reg [1:0] present = 2'b00 , 
    output reg [1:0] next = 2'b00
);

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;
    
    always @(posedge clk) begin
        if(reset == 1) begin
            present <= S0;
        end
        else
            present <= next;
    end

    always @(present , K1 , K2) begin
        next = S0; //default state
        case(present)
            S0 : begin
                if(K1 == 0)
                    next = S3;
                else if((K1 == 1) & (K2 == 1))
                    next = S2;
                else
                    next = S1;
            end
            S1 : begin
                next = S2;
            end
            S2 : begin
                if(K1 == 0)
                    next = S3;
                else if((K1 == 1) & (K2 == 1))
                    next = S2;
                else
                    next = S1;
            end
            S3 : begin
                next = S3;
            end    
        endcase
    end
    always @(*) begin
        subract = (present == S2) ? 1 : 0;
        swap = (present == S1) ? 1 : 0;
        selectxy = (present == S0) ? 1 : 0;
        loadxr = ((present == S0) | (present == S1) | (present == S2)) ? 1 : 0;
        loadyr = ((present == S0) | (present == S1)) ? 1 : 0;
    end

endmodule 
