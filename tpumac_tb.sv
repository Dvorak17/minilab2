module tpumac_tb();

  reg clk, rst, en, wr_en;

  reg signed [7:0] Ain, Bin;
  reg signed [15:0] Cin;

  wire [7:0] Aout, Bout;
  wire [15:0] Cout;

  tpumac accum (
    .clk(clk),
    .rst_n(~rst),
    .WrEn(wr_en),
    .en(en),
    .Ain(Ain),
    .Bin(Bin),
    .Cin(Cin),
    .Aout(Aout),
    .Bout(Bout),
    .Cout(Cout)
  );

  initial begin
    wr_en = 0;
    clk = 0;
    rst = 0;
    en = 0;

    @(posedge clk);

    rst = 1;

    @(posedge clk);

    en = 1;
    Ain = 3;
    Bin = 3;
    Cin = 3;

    @(posedge clk);

    en = 0;

    if (Aout !== 8'h3 || Bout !== 8'h3 || Cout !== 16'h0C) begin
      $display("Failure, expected Aout = 3, Bout = 3, Cout = 12. Found Aout=%d, Bout=%d, Cout=%d", Aout, Bout, Cout);
      $stop();
    end
  end

  always
    #5 clk = !clk;

endmodule
