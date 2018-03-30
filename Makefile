SOURCE=samples/sample.c-

all:
	lex -o src/lex.yy.c src/cminus.l
	gcc -I include/ src/main.c src/lex.yy.c -o gcc- -ll

clean:
	rm -rf gcc-
	rm -rf src/lex.yy.c

run:
	./gcc- ${SOURCE}    # trocar pelo arquivo que quiser 
	#@rm -rf tmp.txt