# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'
require 'diffy'

module Jekyll
  PATTERNSLIB_DOCS_PATH = 'src/bower_components/patternslib/docs'
  PATTERNSLIB_PAT_PATH = 'src/bower_components/patternslib/docs/patterns'
  COPIED_DOCS_PATH = 'docs'

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    def copy_docs_if_necessary
      # See if there is a difference between the canonical docs and the ones
      # copied to Patterns-site and if there is, copy the canonical docs over.
      dirty = false
      if Dir.exist?(COPIED_DOCS_PATH)
        folders = Pathname.new(PATTERNSLIB_PAT_PATH).children.select { |c| c.directory? }
        folders.each() do |path|
          pattern = path.sub(/^#{PATTERNSLIB_PAT_PATH}\//, '')

          Dir.foreach(path) do |item|
            next if item == '.' or item == '..'
            original = "#{path}/#{item}"
            if not File.file? original
              puts ">> #{original}"
              next
            end
            basename = File.basename item
            if basename.end_with?(".sw?") or basename.end_with?("~") or basename.start_with?(".")
              next
            end
            new = "#{COPIED_DOCS_PATH}/patterns/#{pattern}/#{basename}"
            diff = Diffy::Diff.new(new, original, :source => 'files').to_s(:text)
            if not diff.empty?
              dirty = true
              puts "\nFile #{new} is out of sync, will be fixed now."
            end
          end
        end
      end
      if (not Dir.exist?(COPIED_DOCS_PATH)) or dirty
        FileUtils.cp_r(PATTERNSLIB_DOCS_PATH, COPIED_DOCS_PATH)
        puts "Copying over the documentation files from Patternslib"
      end
    end

    def generate_docs(site)
      # Make sure that the canonical docs (e.g. from Patternslib) are available
      # in the _site directory.
      patterns = []
      self.copy_docs_if_necessary()
      folders = Pathname.new(PATTERNSLIB_PAT_PATH).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{PATTERNSLIB_PAT_PATH}/, '')
        patterns << pattern_name

        Dir.foreach(path) do |item|
          next if item == '.' or item == '..'
          next if not File.file?(item)
          site.static_files << Jekyll::StaticFile.new(site, site.source, "#{COPIED_DOCS_PATH}/patterns#{pattern_name}", item)
        end
      end
    patterns
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the project pages.
  class DocsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.generate_docs site
    end
  end

end

# vim: sw=2 expandtab
