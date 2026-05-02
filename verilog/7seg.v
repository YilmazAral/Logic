module tb_sevenSeg;
    wire A, B, C, D, E, F, G;
    wire [3:0] I;

    sevenSeg s(A, B, C, D, E, F, G, I);
    test_all ta(A, B, C, D, E, F, G, I);

endmodule

module test_all(
    input A, B, C, D, E, F, G,
    output reg [3:0] I
);

    integer i;

    initial begin
        $monitor("I = %d A = %b B = %b C = %b D = %b E = %b F = %b G = %b", I, A, B, C, D, E, F, G);

        I = 0;

        for (i = 0; i < 16; i = i + 1) begin
            #1 I = i;
        end

        #1 $finish;
    end

endmodule
/*
module Seg_test(
    input O,
    output reg [3:0] I
);

    integer i;

    initial begin
        $monitor("I = %d O = %b", I, O);

        I = 0;
    
        for (i = 0; i < 10; i = i + 1) begin
            #1 I = i;
        end

        #1 $finish;
    end

endmodule
*/
module aSeg(
    output O,
    input [3:0] I
);

    assign O = I[3] | I[1] | (I[2] ~^ I[0]);

endmodule

module bSeg(
    output O,
    input [3:0] I
);

    assign O = I[3] | ~I[2] | (I[1] ~^ I[0]);

endmodule

module cSeg(
    output O,
    input [3:0] I
);

    assign O = I[2] | ~I[1] | I[0];

endmodule

module dSeg(
    output O,
    input [3:0] I
);

    assign O = I[3] | (~I[2] | I[1] | I[0]) & (~I[0] | I[2] ^ I[1]);

endmodule

module eSeg(
    output O,
    input [3:0] I
);

    assign O = ~I[0] & (I[1] | ~I[2]);

endmodule

module fSeg(
    output O,
    input [3:0] I
);

    assign O = ~I[1] & (I[3] | I[2]) | ~I[0] & (I[2] | ~I[1]);

endmodule

module gSeg(
    output O,
    input [3:0] I
);

    or
        o0(M0, I[3], I[2], I[1]),
        o1(M1, ~I[2], ~I[1], ~I[0]);
    and
        a0(O, M0, M1);

endmodule

module sevenSeg(
    output wire A, B, C, D, E, F, G,
    input [3:0] I
);
    wire dontCare;
    
    assign dontCare = ~I[3] | (~I[2] & ~I[1]);

    aSeg a(tmpA, I);
    bSeg b(tmpB, I);
    cSeg c(tmpC, I);
    dSeg d(tmpD, I);
    eSeg e(tmpE, I);
    fSeg f(tmpF, I);
    gSeg g(tmpG, I);

    assign A = tmpA & dontCare;
    assign B = tmpB & dontCare;
    assign C = tmpC & dontCare;
    assign D = tmpD & dontCare;
    assign F = tmpF & dontCare;
    assign E = tmpE & dontCare;
    assign G = tmpG & dontCare;

endmodule