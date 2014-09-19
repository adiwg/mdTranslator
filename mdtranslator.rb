#!/usr/bin/env ruby
# ADIwg mdTranslator - Thor CLI for mdtranslator

# History:
# 	Stan Smith 2014-07-15 original script
#   Stan Smith 2014-09-02 changed name to mdtranslator
#   Stan Smith 2014-09-15 added format and callback options

# uncomment next 2 lines during development to run from code (not gem) ....
lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'thor'
require 'adiwg-mdtranslator'

class Mdtranslator < Thor

	# basic cli description
	desc 'translate [FILE]', %q{Pass JSON string or filename plus parameters to mdtranslator translate}
	long_desc <<-LONGDESC
	    'mdtranslator translate' provides command line access to the ADIWG metadata translator
 with options to select the input file reader, select writer output format, show empty tags
 in XML outputs, and choose level of validation for JSON inputs.
	LONGDESC
	# define cli options
	method_option :reader, :aliases => '-r', :desc => 'Name of reader to read your input', :default => 'adiwgJson'
	method_option :writer, :aliases => '-w', :desc => 'Name of writer to create your metadata, or leave blank to validate input only'
	method_option :validate, :aliases => '-v', :desc => 'Specify level of validation to be performed', :enum => %w{none normal strict}, :default => 'normal'
	method_option :showAllTags, :aliases => '-s', :desc => 'Include tags for unused attributes', :type => :boolean, :default => false

	# accept command and options
	def translate(file)

		# test to see if file parameter is file or json
		if File.exist?(file)
			# read file
			my_file = File.open(file, 'r')
			fileObj = my_file.read
			my_file.close
		else
			fileObj = file
		end

		# for testing
		# puts 'reader: ' + options[:reader]
		# puts 'writer: ' + options[:writer]
		# puts 'validation level: ' + options[:validate]
		# puts 'showAllTags: ' + options[:showAllTags].to_s
		# require 'pp'
		# pp $LOAD_PATH
		# pp fileObj

		# call mdtranslator
		metadata = ADIWG::Mdtranslator.translate(fileObj, options[:reader], options[:writer],
												 options[:validate], options[:showAllTags])

		# for testing
		puts ''
		puts '---------------------=======================BEGIN=========================---------------------------'
		puts metadata.to_s
		puts '---------------------========================END==========================---------------------------'

		return metadata.to_s

	end

	Mdtranslator.start(ARGV)

end
