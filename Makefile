%.c: %.c.rl
	ragel -G2 -o $@ $<

rst_tangle: rst_tangle.o
