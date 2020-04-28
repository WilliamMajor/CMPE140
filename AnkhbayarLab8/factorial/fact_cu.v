`timescale 1ns / 1ps

module fact_cu(
    input wire clk,
    input wire rst,
    input wire go,
    input wire compared,
    input wire error,
    output reg sel1,
    output reg sel2,
    output reg Load_cnt,
    output reg Load_reg,
    output reg EN,
    output reg DONE
    );
        
    parameter   S0 = 4'b0000,
                S1 = 4'b0001,
                S2 = 4'b0010,
                S3 = 4'b0011,
                S4 = 4'b0100,
                S5 = 4'b0101;
                
    reg [3:0] CS, NS;            
    
    always @(CS, go, error, compared)
    begin
        case(CS)
            S0: begin
                    if(go == 1 && error == 0)  NS = S1;
                    else    NS = S0;                
                end
            S1: begin
                    NS = S2;
                end
            S2: begin
                    if(compared)  NS = S3;
                    else    NS = S4;
                end
            S3: begin
                    NS = S2;
                end
            S4: begin
                    NS = S5;
                end    
            S5: begin
                    NS = S0;
                end
            default:    NS = S0;
        endcase     
    end
    
    always @(posedge clk)
        if(rst)   CS = S0;
        else    CS = NS;
    
    
    always @(CS)
    begin
        case(CS)
            S0: begin
                    sel1 = 0;
                    sel2 = 1;
                    Load_cnt = 0;
                    Load_reg = 0;
                    EN = 0;
                    DONE = 0;
                end
            S1: begin
                    Load_cnt = 1;
                    Load_reg = 1;
                end
            S2: begin
                    sel1 = 1;
                    Load_cnt = 0;
                    Load_reg = 0;
                    EN = 0;
                end
            S3: begin
                    Load_reg = 1;
                    EN = 1;
                end
            S4: begin
                    sel2 = 0;              
                end
            S5: begin
                    DONE = 1;
                end
        endcase
    end
endmodule
