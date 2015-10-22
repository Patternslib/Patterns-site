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


## Integration with the Patterns repo

The website includes demos and documentation from the [Patterns repo](https://github.com/Patternslib/Patterns.git)
which means that we need to have a git checkout of it in Patterns-site. Run:

    make patternslib

To automatically have this repo checked out and updated, simply run:

    make designerhappy

Patterns will then be checked out into ./patternslib and the files for the
individual patterns (index.html, scss, documentation.md etc.) are located in ./patternslib/src/pat/${pattern name}/

Jekyll will pick up modifications to these files and because this is a git
checkout, you can also commit and push your changes to Patterns.

### Generating the site

Running ``make designerhappy`` will generate and serve the site.

Otherwise you can also run:

    bundle exec jekyll serve --watch --baseurl ""

### How to include the demos and docs for the individual patterns

The files required for demoing and documenting the individual patterns are in
the [Patterns](https://github.com/Patternslib/Patterns.git) repository in the
the [/src/pat](https://github.com/Patternslib/Patterns/tree/master/src/pat)
folder.

Each pattern has its own subfolder in which you'll find the following files:

- ``index.html`` which contains the HTML markup to demo the pattern which is injected (via
  ``pat-inject``) into the ``_layouts/demo.html`` layout.
- ``documentation.md`` which contains the markdown which is also injected into
  ``_layouts/demo.html``.
- ``${pattern name}.scss`` which is a Sass file containing CSS specific to this pattern.

The scss file is included in [Patterns/_sass/_patterns.scss](https://github.com/Patternslib/Patterns/blob/master/_sass/_patterns.scss)
and this file is in turn included in style/screen.scss inside this repository.

That's how the CSS of the individual patterns get included in the website.

### How to include developer and designer documentation from Patterns

All documentation for designers and developers should reside in the
[docs folder of Patterns](https://github.com/Patternslib/Patterns/tree/master/docs).

We however want to include these docs in the website. We do this similarly to
how how the files for the demos are included.

The docs are then injected via ''pat-injected'' into the `_layout/documentation.html`` layout.

For each doc we must have a post file in _posts/Documentation and the YAML for that doc
must have two arguments:

- ``sub`` which has a value of either ``developer`` or ``designer``
- ``file`` which must have the file name of the file that must be injected from ``Patterns/docs/${sub}``

