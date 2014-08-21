# ADIwg mdTranslator - Thor CLI for mdtranslator

# History:
# 	Stan Smith 2014-07-15 original script

#!/usr/bin/env ruby
require 'thor'
require 'adiwg-mdtranslator'

class Mdtranslatorcli < Thor

	# basic cli description
	desc "mdTranslator CLI (FILE)", "Pass file or JSON with parameters to mdtranslatorcli:translate"

	# define cli options
	method_option :reader, :aliases => "-r", :desc => "Provide name of reader (default: 'adiwg')", :default => "adiwg"
	method_option :writer, :aliases => "-w", :desc => "Provide name of writer (default: 'iso19115_2')", :default => "iso19115_2"
	method_option :showtags, :aliases => "-s", :desc => "Show empty XML tags (default: 'true')", :default => "true", :type => :boolean
	method_option :validation, :aliases => "-v", :desc => "Specify JSON validation level (default: 'none')", :enum => %w{none, json, schema}, :default => "none"

	# accept command and options
	def translate(file)
		my_reader = options[:reader]
		my_writer = options[:writer]
		my_showtags = options[:showtags]
		my_validation = options[:validation]

		# test to see if file parameter is file or json
		if File.exist?(file)
			# read file
			my_file = File.open(file, 'r')
			jsonObj = my_file.read
			my_file.close
		else
			jsonObj = file
		end

		# testing
		# puts "My reader is: " + my_reader
		# puts "My writer is: " + my_writer
		# puts "My show tags is: " + my_showtags.to_s
		# puts "My JSON validation level is: " + my_validation
		# puts "my JSON object is: " + jsonObj.to_s

		# call mdtranslator
		metadata = Mdtranslator.translate(jsonObj, my_reader, my_writer)

		return metadata
	end
end
