# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'

module Jekyll
  PATTERNSLIB_PAT_PATH = 'patternslib/src/pat'

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    def create_static_files(site, path, pattern_name)
      # Create Jekyll:StaticFile instances for all files that need to be copied
      # into the _site directory.
      #
      # The files in ./patternslib/src/pat/${pattern-name}/ will be placed in
      # ./_etc/src/pat
      Dir.foreach(path) do |item|
        next if item == '.' or item == '..'
        item_path = "#{path}/#{item}"
        if File.directory?(item_path)
          self.create_static_files(site, item_path, pattern_name)
        else
          rel_path = item_path.sub(PATTERNSLIB_PAT_PATH, "src/pat")
          rel_path = rel_path.sub(item, '')
          site.static_files << Jekyll::StaticFile.new(site, "#{site.source}/patternslib", rel_path, item)
        end
      end
    end

    def generate_docs(site)
      # Make sure that the canonical docs (e.g. from Patternslib) are available
      # in the _site directory.
      # self.copy_docs_if_necessary()
      folders = Pathname.new(PATTERNSLIB_PAT_PATH).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{PATTERNSLIB_PAT_PATH}/, '')
        self.create_static_files(site, path, pattern_name)
      end
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the project pages.
  class DocsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.generate_docs(site)
    end
  end

end

# vim: sw=2 expandtab
