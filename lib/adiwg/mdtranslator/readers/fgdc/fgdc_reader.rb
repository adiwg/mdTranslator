# fgdc reader

# History:
#  Stan Smith 2017-08-10 original script

require 'nokogiri'
require_relative 'modules/module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            def self.readFile(file, hResponseObj)

               # receive XML file
               if file.nil? || file == ''
                  hResponseObj[:readerStructureMessages] << 'XML file is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # file must be well formed XML
               begin
                  xDoc = Nokogiri::XML(file) { |form| form.strict }
               rescue Nokogiri::XML::SyntaxError => err
                  hResponseObj[:readerStructureMessages] << 'XML file is not well formed'
                  hResponseObj[:readerStructureMessages] << err
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # file must contain an fgdc <metadata> tag
               xMetadata = xDoc.xpath('/metadata')
               if xMetadata.empty?
                  hResponseObj[:readerStructureMessages] << 'FGDC file did not contain a <metadata> tag'
                  hResponseObj[:readerStructurePass] = false
               end

               # load fgdc file into internal object
               return Fgdc.unpack(xDoc, hResponseObj)

            end

         end
      end
   end
end
