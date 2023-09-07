#!/usr/bin/env ruby
# ADIwg mdTranslator - Thor CLI for mdtranslator

# History:
#  Stan Smith 2019-04-11 add 'iso19115-1' option to writer enum list
#  Stan Smith 2018-05-04 add support for reader execution messages
#  Stan Smith 2018-04-07 add 'fgdc' option to reader and writer enum list
#  Stan Smith 2018-02-26 add 'forceValid' parameter
#  Stan Smith 2017-04-21 removed inline CSS option
#  Stan Smith 2015-07-17 added method_options to provide custom CSS
#  Stan Smith 2014-01-16 changed ADIWG::Mdtranslator.translate() to keyword parameter list
#  Stan Smith 2014-12-29 changed default reader from adiwgJson to mdJson
#  Stan Smith 2014-10-09 added version command to the CLI
#  Stan Smith 2014-09-21 coded cli to 0.8.0 api
#  Stan Smith 2014-09-02 changed name to mdtranslator
# 	Stan Smith 2014-07-15 original script

require 'thor'

class MdtranslatorCLI < Thor

   # exit_on_failure added to exit with code 1 if thor cannot complete task
   # such as if required parameters are missing
   def self.exit_on_failure?
      true
   end

   # basic cli description
   desc 'translate [FILE]', %q{Pass JSON string or filename plus parameters to mdtranslator translate}
   long_desc <<-LONGDESC
	'mdtranslator translate' provides command line access to the ADIwg metadata translator, mdTranslator.  The 'translate'
method converts input metadata to supported established metadata formats.  The CLI accepts an input metadata
file with options to select the input reader format, writer output format, display empty tags in XML and FGDC outputs, 
force output metadata to meet standard, add personalized CSS to headers to HTML output, 
and to choose the level of validation for mdJson input files.
   LONGDESC
   # define cli options
   method_option :reader, :aliases => '-r', :desc => 'Reader to read your input metadata file',
                 :enum => %w{mdJson sbJson fgdc}, :required => true
   method_option :writer, :aliases => '-w',
                 :desc => 'Writer to create your output metadata file, leave blank to validate input only',
                 :enum => %w{fgdc html iso19110 iso19115_1 iso19115_2 mdJson sbJson simple_html dcat_us}
   method_option :validate, :aliases => '-v', :desc => 'Specify level of validation to be performed',
                 :enum => %w{none normal strict}, :default => 'normal'
   method_option :forceValid, :aliases => '-f', :desc => 'Insert tags for required elements missing from input',
                 :type => :boolean, :default => true
   method_option :showAllTags, :aliases => '-s', :desc => 'Include tags for unused attributes',
                 :type => :boolean, :default => false
   method_option :messages, :aliases => '-m', :desc => 'On error return messages as formatted text or json object',
                 :enum => %w{json text}, :default => 'text'
   method_option :returnObject, :aliases => '-o', :desc => 'Return full JSON object generated by translator',
                 :type => :boolean, :default => false
   method_option :cssLink, :desc => 'Fully qualified link to a CSS file to customize HTML writer output',
                 :type => :string

   # accept command and options
   def translate(file)

      # test to see if file parameter is a local file name
      # if not ... assumed it is a JSON string
      # note: this will need to be modified if/when a reader is added that is not in JSON format
      if File.exist?(file)
         # read file
         my_file = File.open(file, 'r')
         fileObj = my_file.read
         my_file.close
      else
         fileObj = file
      end

      # for testing parameters
      # puts 'reader: ' + options[:reader]
      # puts 'writer: ' + options[:writer]
      # puts 'validation level: ' + options[:validate]
      # puts 'showAllTags: ' + options[:showAllTags].to_s
      # puts 'forceValid: ' + options[:forceValid].to_s
      # puts 'message format: ' + options[:messages]
      # puts 'return object: ' + options[:returnObject].to_s
      # puts 'css link: ' + options[:cssLink]
      # puts 'forceValid: ' + options[:forceValid].to_s

      # call mdtranslator
      mdReturn = ADIWG::Mdtranslator.translate(
         file: fileObj,
         reader: options[:reader],
         writer: options[:writer],
         validate: options[:validate],
         forceValid: options[:forceValid],
         showAllTags: options[:showAllTags],
         cssLink: options[:cssLink])

      # determine return content and type of return ...
      if mdReturn[:readerStructurePass] && mdReturn[:readerValidationPass] && mdReturn[:readerExecutionPass]

         # no problem was found with the input file
         if options[:writer].nil?
            # if no writer was specified the input was being validated only,
            # ...no writer output will have been generated,
            # ...and the return will be a string unless json was requested
            if options[:messages] == 'json'
               $stdout.write mdReturn.to_json
               return
            else
               $stdout.write 'Success'
               return
            end
         else
            # a writer was specified,
            # output is expected from the translator's writer
            if mdReturn[:writerPass]
               # writer output was generated
               # ...return the writer output in its native format unless json was requested
               if options[:returnObject]
                  $stdout.write mdReturn.to_json
                  return
               else
                  $stdout.write mdReturn[:writerOutput].to_s
                  return
               end
            else
               # the writer failed or generated warnings to be reported
               # ...return the messages as a string unless json was requested
               if options[:messages] == 'json'
                  $stdout.write mdReturn.to_json
                  return
               else
                  # build a string with messages issues from parser and validator
                  s = ''
                  s += "Failed\n"
                  s += "Writer failed to generate output or issued ERROR OR WARNING messages \n"
                  s += "See following messages for further information\n"

                  # post structure messages
                  i = 0
                  mdReturn[:writerMessages].each do |message|
                     i += 1
                     s += "\nMessage: #{i}\n"
                     s += message + "\n"
                  end

                  $stdout.write s
                  return

               end
            end
         end

      else

         # problems were found with the input file

         # if no writer was specified the input was being validated only,
         # ...no writer output will have been generated,
         # ...and return is always expected to be a string
         if options[:messages] == 'json'
            $stdout.write mdReturn.to_json
            return
         else
            # build a string with messages issued from parser, validator, or reader
            s = ''
            s += "Failed\n"
            s += "Input failed to pass either file structure, validation, or content requirements\n"
            s += "See following messages for further information\n"

            # post structure messages
            if mdReturn[:readerStructurePass]
               s += "Success - Input structure is valid\n"
            else
               s += "Fail - Structure of input file is invalid - see following message(s):\n"
               i = 0
               mdReturn[:readerStructureMessages].each do |message|
                  i += 1
                  s += "\nMessage: #{i}\n"
                  s += message.to_s + "\n"
               end
            end

            # post validator messages
            unless mdReturn[:readerValidationPass].nil?
               if mdReturn[:readerValidationPass]
                  s += "Success - Input content passes schema definition\n"
               else
                  s += "Fail - Input content did not pass schema validation - see following message(s):\n"
                  i = 0
                  mdReturn[:readerValidationMessages].each do |message|
                     i += 1
                     s += "\nMessage: #{i}\n"
                     s += message.to_s + "\n"
                  end
               end
            end

            # post reader execution messages
            unless mdReturn[:readerExecutionPass].nil?
               if mdReturn[:readerExecutionPass]
                  s += "Success - Reader execution successful\n"
               else
                  s += "Fail - Reader execution failed - see following message(s):\n"
                  i = 0
                  mdReturn[:readerExecutionMessages].each do |message|
                     i += 1
                     s += "\nMessage: #{i}\n"
                     s += message.to_s + "\n"
                  end
               end
            end

            $stdout.write s
            return

         end
      end

   end

   desc 'version', %q{Returns the version of mdTranslator}
   long_desc <<-LONGDESC
		'mdtranslator version' returns the version number for mdTranslator
   LONGDESC

   def version
      $stdout.write ADIWG::Mdtranslator::VERSION
   end
end
