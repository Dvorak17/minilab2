module tpumac_tb();

  reg clk, rst, en, wr_en;

  reg signed [7:0] Ain, Bin;
  reg signed [15:0] Cin;

  wire [7:0] Aout, Bout;
  wire [15:0] Cout;

  tpumac accum (
    .clk(clk),
    .rst_n(rst),
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
	for (int i = 0; i < 100; i = i+1) begin
		en = 1;
		Ain = i;
		Bin = i;
		@(posedge clk);
		@(posedge clk);
		if (Aout !== i || Bout !== i) begin
			$display("Failure, expected Aout = %d, Bout = %d. Found Aout=%d, Bout=%d",i, i, Aout, Bout);
			$stop();
		end
	end

	$display("All tests passed!");
	$stop();
  end

  always
    #5 clk = !clk;

endmodule
