.PHONY: run clean

CFLAGS = -g -O0

run: fibon
	./$<

fibon: fibon.o fun.o
	$(CC) $(CFLAGS) -o $@ $?

%.0 : %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -rf *.o *~ fibon
