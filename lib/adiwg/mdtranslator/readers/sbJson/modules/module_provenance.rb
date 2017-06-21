# unpack provenance
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-20 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Provenance

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # title
                  if hSbJson.has_key?('provenance')
                     hSbProv = hSbJson['provenance']

                     if hSbProv.has_key?('dateCreated')
                        unless hSbProv['dateCreated'].nil? || hSbProv['dateCreated'] == ''
                           hDate = intMetadataClass.newDate
                           hReturn = AdiwgDateTimeFun.dateTimeFromString(hSbProv['dateCreated'])
                           hDate[:date] = hReturn[0]
                           hDate[:dateResolution] = hReturn[1]
                           hDate[:dateType] = 'creation'
                           hCitation[:dates] << hDate
                        end
                     end

                     if hSbProv.has_key?('lastUpdated')
                        unless hSbProv['lastUpdated'].nil? || hSbProv['lastUpdated'] == ''
                           hDate = intMetadataClass.newDate
                           hReturn = AdiwgDateTimeFun.dateTimeFromString(hSbProv['lastUpdated'])
                           hDate[:date] = hReturn[0]
                           hDate[:dateResolution] = hReturn[1]
                           hDate[:dateType] = 'lastUpdate'
                           hCitation[:dates] << hDate
                        end
                     end

                  end

                  return hCitation

               end

            end

         end
      end
   end
end
