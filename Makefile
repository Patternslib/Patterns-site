SASS        ?= bundle

serve::
	bundle exec jekyll serve  --baseurl "" --host "0.0.0.0"

.PHONY: serve
