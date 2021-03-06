#!/usr/bin/env ruby

require "thor"
require "fileutils"
require "tty-spinner"

README_FILE = "https://raw.githubusercontent.com/afeiship/docify-zip/master/files/README.txt"
URL_FILE = "https://raw.githubusercontent.com/afeiship/docify-zip/master/files/www.52doc.com.url"
LOC_FILE = "https://raw.githubusercontent.com/afeiship/docify-zip/master/files/www.52doc.com.webloc"

# Could not find command "thor_cli:docify_zip:zip" in "thor_cli:docify_zip" namespace.
module ThorCli
  class DocifyZip < Thor
    desc "zip FILENAME, SUFFIX, PASSWORD", "Zip with thor cli for docify."
    option :force, :type => :boolean

    def zip(filename, suffix = "", password = "")
      name = File.file?(filename) ? File.basename(filename, ".*") : File.basename(File.dirname(filename))

      spinner = TTY::Spinner.new("[:spinner] Zipping #{name}...", format: :spin)
      spinner.auto_spin
      # cache readme
      if !File.exist?("/tmp/README.txt") || options[:force]
        system "https_proxy=http://127.0.0.1:9090 wget -q --directory-prefix=/tmp #{README_FILE}"
        system "https_proxy=http://127.0.0.1:9090 wget -q --directory-prefix=/tmp #{URL_FILE}"
        system "https_proxy=http://127.0.0.1:9090 wget -q --directory-prefix=/tmp #{LOC_FILE}"
      end

      command = password.empty? ? "" : " --password #{password}"
      system "zip -jq '#{name}#{suffix}.zip' #{filename} /tmp/README.txt /tmp/www.52doc.com.* #{command}"
      spinner.success("(successful)")
    end

    def self.exit_on_failure?
      false
    end
  end
end

ThorCli::DocifyZip.start(ARGV)

# ruby src/index.rb hello boilerplate-book-notes
