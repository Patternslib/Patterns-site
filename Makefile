SASS            ?= ./.bundle/bin/sass
BUNDLE          ?= ./.bundle/bin/bundle

stamp-npm: package.json
	@npm install
	@touch stamp-npm
	@echo "Dependencies loaded successfully."

stamp-bundler:
	mkdir -p .bundle
	gem install --user bundler --bindir .bundle/bin
	$(BUNDLE) install --path .bundle --binstubs .bundle/bin
	touch stamp-bundler

bundle: stamp-npm		  ## Build a custom javascript bundle
	@npm run build
	@echo "The bundle has been built."

		
serve-designer:: stamp-bundler bundle
	$(BUNDLE) exec jekyll serve

.PHONY: serve
serve:: stamp-bundler bundle
	$(BUNDLE) exec jekyll serve  --baseurl "" --host "0.0.0.0"

.PHONY: clean
clean::
	@rm -f stamp-npm
	@rm -rf node_modules
	@echo "All cleaned up."

.PHONY: designerhappy
designerhappy:: patternslib bundle serve-designer
