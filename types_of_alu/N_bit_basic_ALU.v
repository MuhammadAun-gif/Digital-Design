module N_bit_basic_ALU #(parameter WIDTH = 32)
                        (input [WIDTH - 1:0] A,B,
                        input [1:0] ALUControl,
                        output [WIDTH - 1:0] Result);

    wire cout;  
    wire [WIDTH - 1:0] sum ;
                                                    
    assign {cout, sum} = (ALUControl[0] == 1'b0) ? (A + B) : (A + ((~B) + 1));

    assign Result = (ALUControl == 2'b00) ? sum :
                    (ALUControl == 2'b01) ? sum :
                    (ALUControl == 2'b10) ? A&B :
                    (ALUControl == 2'b11) ? A|B : ({32{1'b0}});
 
endmodule
