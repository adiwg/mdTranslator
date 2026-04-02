# DCAT-US reader - process and direct dcat_us ingest to internal data structure
# DCAT-US Schema v1.1 (Project Open Data Metadata Schema)
# https://resources.data.gov/resources/dcat-us/

# History:
#  2026-04-02 original script

require 'json'
require_relative 'version'
require_relative 'modules/module_dcat_us'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            def self.readFile(file, hResponseObj)

               # receive json file into ruby hash
               begin
                  hDcatUs = JSON.parse(file)
               rescue JSON::JSONError => err
                  hResponseObj[:readerStructurePass] = false
                  hResponseObj[:readerStructureMessages] << 'Parsing DCAT-US JSON failed - see following message(s):'
                  hResponseObj[:readerStructureMessages] << err.to_s.slice(0, 300)
                  return {}
               end

               # file must contain a non-empty JSON object
               if hDcatUs.empty?
                  hResponseObj[:readerStructureMessages] << 'ERROR: DCAT-US object is empty'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # load DCAT-US file into internal object
               return DcatUs.unpack(hDcatUs, hResponseObj)

            end

         end
      end
   end
end
