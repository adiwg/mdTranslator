# ADIwg mdTranslator - Thor CLI for mdtranslator

# History:
# 	Stan Smith 2014-07-15 original script

#!/usr/bin/env ruby
require 'thor'
require 'adiwg-mdtranslator'

class Mdtranslatorcli < Thor

	# basic cli description
	desc 'mdTranslator CLI (FILE)', %q{Pass file or JSON with parameters to mdtranslatorcli:translate}
	long_desc <<-LONGDESC

	LONGDESC
	# define cli options
	method_option :reader, :aliases => '-r', :desc => "Provide name of reader (default: 'adiwg')"
	method_option :writer, :aliases => '-w', :desc => "Provide name of writer (default: 'iso19115_2')"
	method_option :showtags, :aliases => '-s', :desc => "Show empty XML tags (default: 'true')", :type => :boolean
	method_option :validation, :aliases => '-v', :desc => "Specify JSON validation level (default: 'none')", :enum => %w{none, json, schema}

	# accept command and options
	def translate(file)

		# test to see if file parameter is file or json
		if File.exist?(file)
			# read file
			my_file = File.open(file, 'r')
			jsonObj = my_file.read
			my_file.close
		else
			jsonObj = file
		end

		# for testing
		# puts 'My reader is: ' + options[:reader]
		# puts 'My writer is: ' + options[:writer]
		# puts 'My show tags is: ' + options[:showtags].to_s
		# puts 'My JSON validation level is: ' + options[:validation]
		# puts 'my JSON object is: ' + jsonObj.to_s

		# call mdtranslator
		metadata = Mdtranslator.translate(jsonObj, options[:reader], options[:writer], options[:showtags], options[:validation])

		return metadata
	end
end
