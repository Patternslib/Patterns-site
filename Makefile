SASS        ?= bundle

serve::
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0"

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
		git checkout docs-refactor; \
	 else \
		cd patternslib && git checkout docs-refactor; git pull origin docs-refactor && cd ..; fi;

designerhappy:: patternslib serve

.PHONY: serve designerhappy checkout
