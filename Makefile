SASS        ?= bundle

serve::
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0"

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
	 fi;
	@echo "The patternslib checkout is there. You can run jekyll now."

designerhappy:: patternslib

.PHONY: serve designerhappy checkout
