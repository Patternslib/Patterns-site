# Patterns

Patterns is a JavaScript library that enables designers to build rich
interactive prototypes without the need for writing any JavaScript. All events
are triggered by classes and other attributes in the HTML, without abusing the
HTML as a programming language. Accessibility, SEO and well structured HTML are
core values of Patterns.

## Browser support

Patterns aims to support at least the two latest major versions of all popular browsers.

Currently that means:

- Apple Safari 5+
- Google Chrome 20+
- Microsoft Internet Explorer 8+

Other browser version may work too, but are not actively tested against.

## Setup

### Installing dependencies

Prerequisites:

- node.js >0.10 install from nodejs.org

You can check node is present via:

    nodejs -v

- jekyll > 1.5 install following the instructions on https://help.github.com/articles/using-jekyll-with-pages

On ubuntu:

    sudo apt-get install ruby1.9.3
    sudo gem install bundler

Now install jekyll itself:

    git clone git@github.com:Patternslib/Patterns-site.git
    cd Patterns-site
    sudo bundle install

[Bourbon](http://bourbon.io) and [compass](http://compass-style.org) will be installed as part of `bundle install` .

### Generating the site

    bundle exec jekyll serve --watch --baseurl ""
