
all:
	lex cminus.l
	gcc lex.yy.c -o gcc- -ll

run:
	./gcc- sample.c-    # trocar pelo arquivo que quiser 
	rm -rf tmp.txt