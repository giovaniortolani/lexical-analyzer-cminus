SOURCE=sample/sample.c-

all:
	lex cminus.l
	gcc main.c lex.yy.c -o gcc- -ll

clean:
	rm -rf gcc-

run:
	./gcc- ${SOURCE}    # trocar pelo arquivo que quiser 
	@#rm -rf tmp.txt