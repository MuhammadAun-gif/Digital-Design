// clks_per_bit = (Frequency of i_clk) / (Frequency of UART)
// Example: 25MHz Clock (On Nandland Go Board), 115,200 Baud Rate ==> (25,000,000/115,200) = 217



module uart_rx #(parameter clks_per_bit = 217)  // Set based on Frequency on the FPGA Board
                (
                    input i_clk,                // Input clock
                    input i_rx_serial,          // Serial data stream coming from the computer 
                    output o_rx_DV,             // Ouput Data Valid - Single Pulse, 1 clk cycle wide
                    output [7:0] o_rx_Byte      // The actual byte that we receive from the computer
                );
    
    typedef enum logic [2:0] {idle, rx_start_bit, rx_data_bits, rx_stop_bit, cleanup} statetype;
    statetype state;

    logic[7:0] r_clk_count = 0;
    logic[2:0] r_bit_index = 0; // 8 bits total
    logic[7:0] r_rx_Byte = 0;
    logic      r_rx_DV = 0;

    // Purpose: Control the RX state machine
    always_ff @(posedge i_clk) 
    begin
        case (state)

            idle: 
                begin 
                    r_rx_DV <= 1'b0;
                    r_clk_count <= 0;
                    r_bit_index <= 0;

                    if(i_rx_serial == 1'b0)     // Start Bit Detected
                        state <= rx_start_bit; 
                    else
                        state <= idle;
                end
            
            // Check the middle of the start bit to make sure it is still low
            rx_start_bits:
                begin
                    

                end

        endcase
    end


    
endmodule
