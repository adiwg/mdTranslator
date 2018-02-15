# MdTranslator - controller for evaluating and directing writers

# History:
#  Stan Smith 2016-11-14 refactored for mdTranslator 2.0.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-03-04 changed method of setting $WriterNS
#  Stan Smith 2012-12-16 generalized handleWriter to use :writerName
#  Stan Smith 2014-12-11 original script

module ADIWG
   module Mdtranslator
      module Writers

         def self.handleWriter(intObj, hResponseObj)

            # use ':writerRequested' from hResponseObj to build directory path to writer
            # writer's high-level folder must be placed in 'lib/adiwg/mdtranslator/writers/'
            # writer's code must must be in folder named '{writer}'
            # '{writer}' must contain a module named '{writer}_writer.rb'
            # '{writer}_writer.rb' must have a method named 'startWriter()'
            # 'startWriter()' must pass two parameters (intObj, hResponseObj)
            # all writer modules and classes must remain in their private namespace
            # writer namespace is 'ADIWG::Mdtranslator::Writers::{writer}'

            # the writer's high-level
            thisDir = File.dirname(File.expand_path(__FILE__))
            writerDir = File.join(thisDir, hResponseObj[:writerRequested])
            if File.directory?(writerDir)

               # writer folder
               writerModule = File.join(writerDir, hResponseObj[:writerRequested] + '_writer')
               require writerModule

               # writer namespace
               writerNS = hResponseObj[:writerRequested].dup
               writerNS[0] = writerNS[0].upcase

               # pass internal object and hResponseObj to the writer
               hResponseObj[:writerOutput] = ADIWG::Mdtranslator::Writers.const_get(writerNS).startWriter(intObj, hResponseObj)

            else
               hResponseObj[:writerMessages] << "ERROR: Requested writer '#{hResponseObj[:writerRequested]}' cannot be found."
               hResponseObj[:writerPass] = false
            end

            return hResponseObj

         end

         # return writer readme text
         # this is called from the Rails API
         def self.get_writer_readme(writer)

            thisDir = File.dirname(File.expand_path(__FILE__))
            path = File.join(thisDir, writer, 'readme.md')
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

