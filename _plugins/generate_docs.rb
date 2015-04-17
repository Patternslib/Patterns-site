# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'
require 'diffy'

module Jekyll
  DEMO_FOLDER = 'src/bower_components/patternslib/demo'

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    def copy_docs_if_necessary
      # See if there is a difference between the canonical docs and the ones
      # copied to Patterns-site and if there is, copy the canonical docs over.
      dirty = false
      if Dir.exist?('demo')
        folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
        folders.each() do |path|
          pattern = path.sub(/^#{DEMO_FOLDER}\//, '')

          Dir.foreach(path) do |item|
            next if item == '.' or item == '..'
            original = "#{path}/#{item}"
            next if not File.file? original
            basename = File.basename item
            if basename.end_with?(".sw?") or basename.end_with?("~") or basename.start_with?(".")
              next
            end
            new = "demo/#{pattern}/#{basename}"
            diff = Diffy::Diff.new(new, original, :source => 'files').to_s(:text)
            if not diff.empty?
              dirty = true
              puts "\nFile #{new} is out of sync, will be fixed now."
            end
          end
        end
      end
      if (not Dir.exist?('demo')) or dirty
        FileUtils.cp_r(DEMO_FOLDER, "./")
        puts "Copying over the documentation files from Patternslib"
      end
    end

    def generate_docs(site)
      # Make sure that the canonical docs (e.g. from Patternslib) are available
      # in the _site directory.
      patterns = []
      self.copy_docs_if_necessary()
      folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{DEMO_FOLDER}/, '')
        patterns << pattern_name

        Dir.foreach(path) do |item|
          next if item == '.' or item == '..'
          next if not File.file?(item)
          site.static_files << Jekyll::StaticFile.new(site, site.source, "./demo/#{pattern_name}", item)
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
