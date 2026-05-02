module tb_sevenSeg;
    wire O;
    wire [3:0] I;

    aSeg a(O, I);
    aSeg_test ta(O, I);

endmodule

module aSeg_test(
    input O,
    output reg [3:0] I
);

    initial begin
        $monitor("I = %b%b%b%b A = %b", I[3], I[2], I[1], I[0], O);
    
    always @(*) begin
        integer i;

        for (i = 0; i < 16; i = i + 1) begin
            #1 I = i;
        end
    
    end
    end

endmodule

module aSeg(
    output O,
    input [3:0] I
);

    assign O = I[3] + I[1] + (I[2] ~^ I[0]);

endmodule

module bSeg(
    output O,
    input [3:0] I
);

    assign O = I[3] + I[2] + (I[1] ~^ I[0]);

endmodule
/*
module cSeg(
    output O,
    input [3:0] I
);

    

endmodule

module sevenSeg(
    output wire A, B, C, D, E, F, G,
    input [3:0] I
);
endmodule*/