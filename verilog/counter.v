module testbench;
    wire [1:0] W;
    wire [2:0] Q;

    test_counter3b_basic t(W[0], W[1], Q);
    counter3b_basic c(W[0], W[1], Q);

endmodule

module d_latch (
    output Q, Q_bar,
    input D, EN, Rst_bar
);

or
    reset(Q_bar, latchQ_bar, ~Rst_bar);

nor
    s(S, ~EN, ~D),
    r(R, ~EN, D),

    qnot(latchQ_bar, S, Q),
    q(Q, Q_bar, R);

endmodule

module d_ff (
    output Q, Q_bar,
    input D, CLK, Rst_bar
);

d_latch master(masterQ, masterQ_bar, D, ~CLK, Rst_bar),
    slave(Q, Q_bar, masterQ, CLK, Rst_bar);
    
endmodule

module t_ff (
    output Q, Q_bar,
    input T, CLK, Rst_bar
);

xor d(D, T, Q);

d_ff ff0(Q, Q_bar, D, CLK, Rst_bar);
    
endmodule

module counter1b (
    input T, CLK, Rst_bar,
    output Q
);

t_ff t0(Q, Qnot, T, CLK, Rst_bar);

endmodule

module test_counter1b_basic (
    output reg CLK, Rst_bar,
    input Q
);

initial begin
    CLK = 0;
    Rst_bar = 0; #1
    Rst_bar = 1;
end

initial begin
    while (1) begin
        #1 CLK = ~CLK;
    end
end

initial begin
    $monitor($time,,, "CLK = %b Rst_bar = %b Q = %b", CLK, Rst_bar, Q);

    #20 $finish;
end

endmodule

module counter1b_basic #(
    parameter HIGH = 1'b1
)(
    input CLK, Rst_bar,
    output Q
);

t_ff t0(Q, Qnot, HIGH, CLK, Rst_bar);

endmodule

module test_counter3b_basic (
    output reg CLK, Rst_bar,
    input [2:0] Q
);

initial begin
    Rst_bar = 0;
    CLK = 0;
    #1 Rst_bar = 1;
end

initial begin
    while (1) begin
        #1 CLK = ~CLK;
    end
end

initial begin
    $monitor($time,,, "CLK = %b Rst_bar = %b Q = %d", CLK, Rst_bar, Q);

    #20 $finish;
end

endmodule

module counter3b_basic #(
    parameter HIGH = 1'b1
) (
    input CLK, Rst_bar,
    output [2:0] Q
);

t_ff t0(Q[0], Qnot0, HIGH, CLK, Rst_bar),
    t1(Q[1], Qnot1, Q[0], CLK, Rst_bar),
    t2(Q[2], Qnot2, Q[0] & Q[1], CLK, Rst_bar);

endmodule