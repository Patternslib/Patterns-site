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
	$(BUNDLE) exec jekyll build --config=_config.yml,_config-patternslib.yml

.PHONY: jekyll-serve
jekyll-serve:: stamp-bundler   ## run jekyll, serve and watch
	$(BUNDLE) exec jekyll serve --config=_config.yml,_config-patternslib.yml

.PHONY: jekyll-serve-blank
jekyll-serve-blank:: stamp-bundler  ## run jekyll, serve and watch (ignoring the baseurl and host settings)
	$(BUNDLE) exec jekyll serve  --baseurl "" --host "0.0.0.0" --config=_config.yml,_config-patternslib.yml

.PHONY: update-patternslib
update-patternslib:
	$(eval PATTERNSLIB_VERSION := $(shell curl https://api.github.com/repos/patternslib/Patterns/releases/latest -s | jq .tag_name -r))
	@printf "bundle_url: https://cdn.jsdelivr.net/npm/@patternslib/patternslib@$(PATTERNSLIB_VERSION)/dist/bundle.min.js\npatternslib_version: $(PATTERNSLIB_VERSION)\n" > _config-patternslib.yml
	@cat _config-patternslib.yml
	@echo # add a newline to output.
	-@git commit _config-patternslib.yml -m"Update Patternslib to $(PATTERNSLIB_VERSION)"

