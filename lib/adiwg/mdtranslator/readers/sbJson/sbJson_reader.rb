# mdJson reader - process and direct mdJson ingest to internal data structure

# History:
#  Stan Smith 2016-06-12 refactor for mdTranslator 2.0
# 	Josh Bradley original script

require 'json'
require_relative 'version'
require_relative 'modules/module_sbJson'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            def self.readFile(file, hResponseObj)

               # receive json file into ruby hash
               begin
                  hSbJson = JSON.parse(file)
               rescue JSON::JSONError => err
                  hResponseObj[:readerStructurePass] = false
                  hResponseObj[:readerStructureMessages] << 'Parsing sbJson Failed - see following message(s):\n'
                  hResponseObj[:readerStructureMessages] << err.to_s.slice(0, 300)
                  return {}
               end

               # file must contain an sbJson object
               if hSbJson.empty?
                  hResponseObj[:readerStructureMessages] << 'sbJson object is empty'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # load sbJson file into internal object
               return SbJson.unpack(hSbJson, hResponseObj)

            end

         end
      end
   end
end
