module N_bit_ALU_with_SLT_Support #(parameter WIDTH = 32)
                                (input [WIDTH - 1:0] A,B,
                                input [2:0] ALUControl,
                                output [WIDTH - 1:0] Result);
    
    wire cout, OverFlow, sum_xor;  
    wire [WIDTH - 1:0] sum ;
                                                    
    assign {cout, sum} = (ALUControl[0] == 1'b0) ? (A + B) : (A + ((~B) + 1));

    assign OverFlow = ((sum[WIDTH - 1] ^ A[WIDTH - 1]) &
                        (~(ALUControl[0] ^ B[WIDTH - 1] ^ A[WIDTH - 1])) & 
                        (~ALUControl[1]));
    
    assign sum_xor = (OverFlow ^ sum[WIDTH - 1]);

    assign Result = (ALUControl == 3'b000) ? sum :
                    (ALUControl == 3'b001) ? sum :
                    (ALUControl == 3'b010) ? A&B :
                    (ALUControl == 3'b011) ? A|B : 
                    (ALUControl == 3'b101) ? {{(WIDTH - 1){1'b0}}, sum_xor} : 
                    ({WIDTH - 1{1'b0}});

endmodule