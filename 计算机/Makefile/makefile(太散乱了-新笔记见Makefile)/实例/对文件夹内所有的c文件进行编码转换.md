```make
SOURCE = $(wildcard $(shell find . -name '*.c'))
CS = $(patsubst %.c,%.cc, $(SOURCE))

all: $(CS)

%.cc: %.c
	iconv -f GB2312 -t utf8 $< -o $@
	mv $@ $<

```
`all`的作用是，给makefile提供一个目标  
