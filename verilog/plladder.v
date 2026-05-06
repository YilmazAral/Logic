module tb_plladder;
    wire [7:0] w1, w2, w3;
    wire w0;

    test_adder t(w0, w1, w2, w3);
    plladder a(w0, w1, w2, w3);
    
endmodule

module test_adder (
    overflow, O, A, B
);

wire [7:0] O;
input [7:0] O;

reg [7:0] A, B;
output [7:0] A, B;

input overflow;
wire overflow;

integer i, j;

initial begin
    $monitor($time,,, "A = %d B = %d O = %d, overflow = %b", A, B, O, overflow);

    for (i = 0; i < 256; i = i +1) begin
        #10 A = i;

        for (j = 0; j < 256; j = j +1) begin
            #10 B = j;
        end
    end

    #10 $finish;
end
    
endmodule

module plladder (
    overflow, O, A, B
);

wire [7:0] A, B;
input [7:0] A, B;

wire [7:0] O;
output [7:0] O;

wire overflow;
output overflow;

wire p0, p1, p2, p3, p4, p5, p6, p7,
    g0, g1, g2, g3, g4, g5, g6, g7,
    c1, c2, c3, c4, c5, c6,

    t1_1,
    t2_1, t2_2,
    t3_1, t3_2, t3_3,
    t4_1, t4_2, t4_3, t4_4,
    t5_1, t5_2, t5_3, t5_4, t5_5,
    t6_1, t6_2, t6_3, t6_4, t6_5, t6_6,
    t7_1, t7_2, t7_3, t7_4, t7_5, t7_6, t7_7;
    
xor #1
    propagate0(p0, A[0], B[0]),
    propagate1(p1, A[1], B[1]),
    propagate2(p2, A[2], B[2]),
    propagate3(p3, A[3], B[3]),
    propagate4(p4, A[4], B[4]),
    propagate5(p5, A[5], B[5]),
    propagate6(p6, A[6], B[6]),
    propagate7(p7, A[7], B[7]);

and #1
    generate0(g0, A[0], B[0]),
    generate1(g1, A[1], B[1]),
    generate2(g2, A[2], B[2]),
    generate3(g3, A[3], B[3]),
    generate4(g4, A[4], B[4]),
    generate5(g5, A[5], B[5]),
    generate6(g6, A[6], B[6]),
    generate7(g7, A[7], B[7]),

//1
    term1_1(t1_1, p1, g0),

//2
    term2_1(t2_1, p2, g1),
    term2_2(t2_2, p2, p1, g0),

//3
    term3_1(t3_1, p3, g2),
    term3_2(t3_2, p3, p2, g1),
    term3_3(t3_3, p3, p2, p1, g0),

//4
    term4_1(t4_1, p4, g3),
    term4_2(t4_2, p4, p3, g2),
    term4_3(t4_3, p4, p3, p2, g1),
    term4_4(t4_4, p4, p3, p2, p1, g0),

//5
    term5_1(t5_1, p5, g4),
    term5_2(t5_2, p5, p4, g3),
    term5_3(t5_3, p5, p4, p3, g2),
    term5_4(t5_4, p5, p4, p3, p2, g1),
    term5_5(t5_5, p5, p4, p3, p2, p1, g0),

//6
    term6_1(t6_1, p6, g5),
    term6_2(t6_2, p6, p5, g4),
    term6_3(t6_3, p6, p5, p4, g3),
    term6_4(t6_4, p6, p5, p4, p3, g2),
    term6_5(t6_5, p6, p5, p4, p3, p2, g1),
    term6_6(t6_6, p6, p5, p4, p3, p2, p1, g0),

//7
    term7_1(t7_1, p7, g6),
    term7_2(t7_2, p7, p6, g5),
    term7_3(t7_3, p7, p6, p5, g4),
    term7_4(t7_4, p7, p6, p5, p4, g3),
    term7_5(t7_5, p7, p6, p5, p4, p3, g2),
    term7_6(t7_6, p7, p6, p5, p4, p3, p2, g1),
    term7_7(t7_7, p7, p6, p5, p4, p3, p2, p1, g0);

or #1
    carry1(c1, g1, t1_1),
    carry2(c2, g2, t2_1, t2_2),
    carry3(c3, g3, t3_1, t3_2, t3_3),
    carry4(c4, g4, t4_1, t4_2, t4_3, t4_4),
    carry5(c5, g5, t5_1, t5_2, t5_3, t5_4, t5_5),
    carry6(c6, g6, t6_1, t6_2, t6_3, t6_4, t6_5, t6_6),
    carry7(overflow, g7, t7_1, t7_2, t7_3, t7_4, t7_5, t7_6, t7_7);

buf #1 digit0(O[0], p0);

xor #1
    digit1(O[1], p1, g0),
    digit2(O[2], p2, c1),
    digit3(O[3], p3, c2),
    digit4(O[4], p4, c3),
    digit5(O[5], p5, c4),
    digit6(O[6], p6, c5),
    digit7(O[7], p7, c6);

endmodule