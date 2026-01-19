module N_bit_ALU_with_flags #(parameter WIDTH = 32)
            (input [WIDTH - 1:0] A,B,
            input [1:0] ALUControl,
            output OverFlow,Carry,Zero,Negative,
            output [WIDTH - 1:0] Result);
    
    wire cout ;
    wire [WIDTH - 1:0] sum;

    assign {cout,sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;

    assign Result = (ALUControl == 2'b00) ? sum :
                    (ALUControl == 2'b01) ? sum :
                    (ALUControl == 2'b10) ? A & B :
                    (ALUControl == 2'b11) ? A | B : {32{1'b0}};
    
    assign OverFlow = ((sum[WIDTH - 1] ^ A[WIDTH - 1]) &
                        (~(ALUControl[0] ^ B[WIDTH - 1] ^ A[WIDTH - 1])) & 
                        (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & cout);
    assign Zero = &(~Result);
    assign Negative = (Result[WIDTH - 1]);

endmodule
