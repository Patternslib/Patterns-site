# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'
require 'diffy'

module Jekyll
  DEMO_FOLDER = 'src/bower_components/patternslib/demo'

  class PatternPage < Page
    def initialize(site, base, dir, pattern)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'demo.html')
      self.data['title'] = pattern.capitalize
      self.data['layout'] = 'demo'
      self.data['pattern'] = pattern
      # FIXME
      self.data['category'] = 'layout'
      self.data['description'] = 'This is a very nice pattern'

      begin
        self.data['contents'] = File.open("#{DEMO_FOLDER}/#{pattern}/documentation.md", "rb").read
      rescue Exception
      end
    end
  end

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site


    def generate_docs(site)

      patterns = []
      dirty = false
      if Dir.exist?('demo')
        folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
        folders.each() do |path|
          pattern_name = path.sub(/^#{DEMO_FOLDER}\//, '') 
          patterns << pattern_name
          file1 = "demo/#{pattern_name}/index.html"
          file2 = "#{DEMO_FOLDER}/#{pattern_name}/index.html"
          diff = Diffy::Diff.new(file1, file2, :source => 'files').to_s(:text)
          if not diff.empty?
            dirty = true
          end
        end
      end
      if (not Dir.exist?('demo')) or dirty
        FileUtils.cp_r(DEMO_FOLDER, "./")
        puts "Copying over the documentation files from Patternslib"
      end

      folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{DEMO_FOLDER}/, '') 
        ["documentation.md", "index.html", "#{pattern_name}.css", "icon.svg"].each() do |file|
          if File.exist?("#{DEMO_FOLDER}/#{pattern_name}/#{file}")
            site.static_files << Jekyll::StaticFile.new(site, site.source, "./demo/#{pattern_name}", file)
          end
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
      patterns = site.generate_docs site
      # if site.layouts.key? 'demo'
      #   patterns.each do |pattern|
      #     site.pages << PatternPage.new(site, site.source, File.join(pattern), pattern.to_s)
      #   end
      # end
    end
  end

end

# vim: sw=2 expandtab
