# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'

module Jekyll

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    DEMO_FOLDER = 'src/bower_components/patternslib/demo'
    
    def generate_docs(site)
      FileUtils.cp_r(DEMO_FOLDER, "./")

      folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{DEMO_FOLDER}/, '') 
        ["documentation.md", "index.html", "#{pattern_name}.css"].each() do |file|
          if File.exist?("#{DEMO_FOLDER}/#{pattern_name}/#{file}")
            site.static_files << Jekyll::StaticFile.new(site, site.source, "./demo/#{pattern_name}", file)
          end
        end
      end
      puts "Copied over the documentation files from Patternslib into _site/${pattern}"
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the project pages.
  class GenerateDocs < Generator
    safe true
    priority :low
    def generate(site)
      site.generate_docs site
    end
  end
end

# vim: sw=2 expandtab
