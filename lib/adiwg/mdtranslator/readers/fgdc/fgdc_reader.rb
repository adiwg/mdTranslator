# fgdc reader

# History:
#  Stan Smith 2018-05-04 add reader version to response object
#  Stan Smith 2017-08-10 original script

require 'nokogiri'
require_relative 'version'
require_relative 'modules/module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            def self.readFile(file, hResponseObj)

               # add FGDC reader version
               hResponseObj[:readerVersionUsed] = ADIWG::Mdtranslator::Readers::Fgdc::VERSION

               # receive XML file
               if file.nil? || file == ''
                  hResponseObj[:readerStructureMessages] << 'ERROR: XML file is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # file must be well formed XML
               begin
                  xDoc = Nokogiri::XML(file) { |form| form.strict }
               rescue Nokogiri::XML::SyntaxError => err
                  hResponseObj[:readerStructureMessages] << 'ERROR: XML file is not well formed'
                  hResponseObj[:readerStructureMessages] << err.to_s
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # file must contain an fgdc <metadata> tag
               xMetadata = xDoc.xpath('/metadata')
               if xMetadata.empty?
                  hResponseObj[:readerValidationMessages] << 'ERROR: FGDC file did not contain a <metadata> tag'
                  hResponseObj[:readerValidationPass] = false
                  return {}
               end

               # load fgdc file into internal object
               return Fgdc.unpack(xDoc, hResponseObj)

            end

         end
      end
   end
end
