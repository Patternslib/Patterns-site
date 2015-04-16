# This plugin copies over the markdown files and example markup from
# Patternslib's demo folder into _site/demo
#
require 'fileutils'
require 'find'
require 'pathname'

module Jekyll

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    DEMO_FOLDER = 'src/bower_components/patternslib/demo/'
    
    def generate_docs 
      folders = Pathname.new(DEMO_FOLDER).children.select { |c| c.directory? }
      folders.each() do |path|
        pattern_name = path.sub(/^#{DEMO_FOLDER}/, '') 
        # name = File.basename('filename', '.doc')[0,4]
        dest_folder = "_site/demo/#{pattern_name}/"
        ["documentation.md", "index.html"].each() do |file|
          begin  
            FileUtils.cp("#{path}/#{file}", dest_folder)
          rescue Exception => e  
              puts e.message  
          end  
        end
      end
      puts "Copied over the documentation files from Patternslib into _site/demo"
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the project pages.
  class GenerateProjects < Generator
    safe true
    priority :low
    def generate(site)
      site.generate_docs
    end
  end
end

# vim: sw=2 expandtab
