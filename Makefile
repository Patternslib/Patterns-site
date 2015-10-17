SASS            ?= ./.bundle/bin/sass
BUNDLE          ?= ./.bundle/bin/bundle

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
	 fi;
	cd patternslib && npm install && ./node_modules/.bin/bower update && cd ..; \

stamp-bundler:
	mkdir -p .bundle
	gem install --user bundler --bindir .bundle/bin
	$(BUNDLE) install --path .bundle --binstubs .bundle/bin
	touch stamp-bundler

dev: stamp-bundler

bundle patternslib/bundle.js:
	@cd patternslib && make bundle && cd ..;
		
serve-designer:: stamp-bundler bundle
	$(BUNDLE) exec jekyll serve

.PHONY: serve
serve:: stamp-bundler bundle
	$(BUNDLE) exec jekyll serve  --baseurl "" --host "0.0.0.0"

.PHONY: clean
clean::
	rm -rf patternslib

.PHONY: designerhappy
designerhappy:: patternslib bundle serve-designer
