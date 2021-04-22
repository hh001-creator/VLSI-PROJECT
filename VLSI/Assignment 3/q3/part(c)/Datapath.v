module DataPath (
    output wire [5:0] Out,
    output wire K1 , K2, //K1 = (XR > 0) , K2 = (XR >= YR)
    output reg[5:0] AR , BR,
    input wire [5:0] A , B,
    input wire reset , subract , swap , selectxy , loadxr,
    loadyr , clk
);
    wire [5:0] reg_AR_in , reg_BR_in , reg_BR_out , reg_AR_out , sub_out;
    assign reg_AR_in = subract ? sub_out : (swap ? reg_BR_out :
           selectxy ? A : reg_AR_out);
    assign reg_BR_in = swap ? reg_AR_out : (selectxy ? B : reg_BR_out);
    always @(posedge clk) begin
        if(reset & loadxr)
            AR <= 0;
        else if (loadxr)
            AR <= reg_AR_in;
    end
    always @(posedge clk) begin
        if(reset & loadyr)
            BR <= 0;
        else if (loadxr)
            BR <= reg_AR_in;
    end
    assign reg_AR_out = AR,
           reg_BR_out = BR,
           Out = reg_BR_out;
    assign sub_out = reg_AR_out - reg_BR_out;
    assign K1 = (reg_AR_out > 0) ? 1 : 0;
    assign K2 = (reg_AR_out >= reg_BR_out) ? 1 : 0;
endmodule