BUNDLE      ?= ./.bundle/bin/bundle

patternslib::
	@if [ ! -d "patternslib" ]; then \
		git clone https://github.com/Patternslib/Patterns.git patternslib; \
	fi;
	(cd patternslib && npm install && ./node_modules/.bin/bower update)

########################################################################
## Install dependencies

stamp-npm: package.json
	@npm install
	@touch stamp-npm
	@echo "Dependencies loaded successfully."

stamp-bundler:
	mkdir -p .bundle
	gem install --user bundler --bindir .bundle/bin
	$(BUNDLE) install --path .bundle --binstubs .bundle/bin
	touch stamp-bundler

clean::    ## Clean up by removing all depencencies
	@rm -f stamp-npm
	@rm -rf node_modules patternslib
	@echo "All cleaned up."

########################################################################
## Build JS

bundle: stamp-npm		  ## Build a custom javascript bundle
	@npm run build
	@echo "The bundle has been built."

# Add help text after each target name starting with ' \#\# '
help:
	@grep " ## " $(MAKEFILE_LIST) | grep -v MAKEFILE_LIST | sed 's/\([^:]*\).*##/\1    /'

jekyll-serve:: patternslib stamp-bundler   ## run jekyll, serve and watch
	bundle exec jekyll serve

jekyll-serve-blank:: patternslib stamp-bundler  ## run jekyll, serve and watch (ignoring the baseurl and host settings)
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0" 


.PHONY: compile-all clean jekyll-serve jekyll-serve-blank bundle help


