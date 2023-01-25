BUNDLE      ?= ./.bundle/bin/bundle

.PHONY: all
all:: jekyll-serve

stamp-bundler:
	mkdir -p .bundle
	gem install --user bundler --bindir .bundle/bin
	$(BUNDLE) install --path .bundle --binstubs .bundle/bin
	touch stamp-bundler

.PHONY: clean
clean::    ## Clean up by removing all depencencies
	@rm -rf .bundle stamp-bundler
	@echo "All cleaned up."

# Add help text after each target name starting with ' \#\# '
.PHONY: help
help:
	@grep " ## " $(MAKEFILE_LIST) | grep -v MAKEFILE_LIST | sed 's/\([^:]*\).*##/\1    /'

.PHONY: jekyll-build
jekyll-build:: stamp-bundler
	$(BUNDLE) exec jekyll build

.PHONY: jekyll-serve
jekyll-serve:: stamp-bundler   ## run jekyll, serve and watch
	$(BUNDLE) exec jekyll serve

.PHONY: jekyll-serve-blank
jekyll-serve-blank:: stamp-bundler  ## run jekyll, serve and watch (ignoring the baseurl and host settings)
	$(BUNDLE) exec jekyll serve  --baseurl "" --host "0.0.0.0"

