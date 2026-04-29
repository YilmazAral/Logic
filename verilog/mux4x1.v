module mux4x1 (
    input [3:0] I,
    input [1:0] S,
    output O
);

assign O = (~S[1] & ~S[0] & I[0])
    | (~S[1] & S[0] & I[1])
    | (S[1] & ~S[0] & I[2])
    | (S[1] & S[0] & I[3]);

endmodule

module test_mux;
    reg [3:0] I;
    reg [1:0] S;
    wire O;

mux4x1 mux0(I, S, O);

initial begin
    $monitor($time,,,"I = %b%b%b%b S = %b%b O = %b",
        I[3], I[2], I[1], I[0], S[1], S[0], O);
    
    #1 I = 4'b0000; S = 2'b00;
    #1 I = 4'b0001; S = 2'b00;

    #1 I = 4'b0000; S = 2'b01;
    #1 I = 4'b0010; S = 2'b01;

    #1 I = 4'b0000; S = 2'b10;
    #1 I = 4'b0100; S = 2'b10;

    #1 I = 4'b0000; S = 2'b11;
    #1 I = 4'b1000; S = 2'b11;

    #1 $finish;
end

endmodule