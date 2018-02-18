# MdTranslator - controller for evaluating and directing readers

# History:
#  Stan Smith 2016-11-12 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-03-04 changed method of setting $WriterNS
#  Stan Smith 2012-12-16 generalized handleReader to use :readerRequested
# 	Stan Smith 2014-12-11 original script

module ADIWG
   module Mdtranslator
      module Readers

         def self.handleReader(file, hResponseObj)

            # use ':readerRequested' from hResponseObj to build directory path to reader
            # reader's high level folder must be placed in 'lib/adiwg/mdtranslator/readers/'
            # reader's code must must be in folder named '{reader}'
            # '{reader}' must contain a module named '{reader}_reader.rb'
            # '{reader}_reader.rb' must have a method named 'readFile()'
            # 'readFile()' must pass two parameters (file, hResponseObj)
            # all reader modules and classes must remain in their private namespace
            # reader namespace is 'ADIWG::Mdtranslator::Readers::{reader}'

            # reader high-level folder
            thisDir = File.dirname(File.expand_path(__FILE__))
            readerDir = File.join(thisDir, hResponseObj[:readerRequested])
            if File.directory?(readerDir)

               # reader folder
               readerModule = File.join(readerDir, hResponseObj[:readerRequested] + '_reader')
               require readerModule

               # reader namespace
               readerNS = hResponseObj[:readerRequested].dup
               readerNS[0] = readerNS[0].upcase

               # reader will create and return the intObj
               return ADIWG::Mdtranslator::Readers.const_get(readerNS).readFile(file, hResponseObj)

            else

               hResponseObj[:readerValidationMessages] << "ERROR: Requested reader '#{hResponseObj[:readerRequested]}' cannot be found."
               hResponseObj[:readerValidationPass] = false

               # return empty intObj
               return {}

            end

         end

         # return reader readme text
         # this is called from the Rails API
         def self.get_reader_readme(reader)

            thisDir = File.dirname(File.expand_path(__FILE__))
            path = File.join(thisDir, reader, 'readme.md')
            if File.exist?(path)
               file = File.open(path, 'r')
               readmeText = file.read
               file.close
               return readmeText
            else
               return 'Readme file not found'
            end

         end

      end
   end
end
