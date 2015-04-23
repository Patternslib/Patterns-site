SASS        ?= bundle

serve::
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0"

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
		cd patternslib && npm install && ./node_modules/.bin/bower update && cd ..; \
	 fi;
	bundle exec jekyll serve

designerhappy:: patternslib

.PHONY: serve designerhappy checkout
