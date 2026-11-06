`timescale 1ns/1ps

module top_tb;

    parameter width = 8;

    reg lin, rin, clk, lr, clr, en, hold, load;
    reg [width-1:0] p_load;

    wire [width-1:0] q;
    reg [width-1:0] expected;

    integer errors;

    top #(.width(width)) dut (
        .lin(lin),
        .rin(rin),
        .clk(clk),
        .lr(lr),
        .clr(clr),
        .en(en),
        .hold(hold),
        .load(load),
        .p_load(p_load),
        .q(q)
    );

    always #5 clk = ~clk;

    task check;
        begin
            @(posedge clk);
            #1;
            if (q !== expected) begin
                $display("FAIL: time=%0t expected=%b actual=%b",
                         $time, expected, q);
                errors = errors + 1;
            end
            else begin
                $display("PASS: time=%0t q=%b", $time, q);
            end
        end
    endtask

    initial begin
         $dumpfile("UniSR.vcd");
         $dumpvars(0,top_tb);
        clk = 0;
        lin = 0;
        rin = 0;
        lr = 0;
        clr = 0;
        en = 0;
        hold = 0;
        load = 0;
        p_load = 0;
        expected = 0;
        errors = 0;

        clr = 1;
        expected = 0;
        check();

        clr = 0;
        load = 1;
        p_load = 8'b10110010;
        expected = 8'b10110010;
        check();

        load = 0;
        en = 1;
        hold = 0;
        lr = 0;
        lin = 1;
        expected = {expected[width-2:0], 1'b1};
        check();

        lin = 0;
        expected = {expected[width-2:0], 1'b0};
        check();

        lr = 1;
        rin = 1;
        expected = {1'b1, expected[width-1:1]};
        check();

        rin = 0;
        expected = {1'b0, expected[width-1:1]};
        check();

        hold = 1;
        check();

        hold = 0;
        en = 0;
        check();

        en = 1;
        load = 1;
        p_load = 8'b11001100;
        expected = 8'b11001100;
        check();

        clr = 1;
        expected = 0;
        check();

        clr = 0;
        load = 0;
        en = 1;
        hold = 0;
        lr = 0;
        lin = 1;
        expected = {expected[width-2:0], 1'b1};
        check();

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

    initial begin
        $dumpfile("universal_shift_register.vcd");
        $dumpvars(0, top_tb);
    end

endmodule