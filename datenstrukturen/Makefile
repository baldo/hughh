all: slides.html

slides.html: TITLE.md List.lhs Stack.lhs NaiveQueue.lhs Queue.lhs Trie.lhs README.md
	@pandoc -f markdown+lhs -w slidy -5 -s --offline -o $@ $+

clean:
	@rm -f slides.html
