SASS        ?= bundle

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
		cd patternslib && npm install && ./node_modules/.bin/bower update && cd ..; \
	 fi;

bundle patternslib/bundle.js:
	@cd patternslib && make bundle && cd ..;
		
serve-designer::
	bundle exec jekyll serve

serve::
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0"

designerhappy:: patternslib serve-designer

.PHONY: serve designerhappy clean
