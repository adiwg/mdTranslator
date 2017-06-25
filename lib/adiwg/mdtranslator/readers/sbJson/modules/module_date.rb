# unpack dates
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-25 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/writers/sbJson/sections/sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Date

               @Namespace = ADIWG::Mdtranslator::Writers::SbJson

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('dates')
                     hSbJson['dates'].each do |hSbDate|
                        hDate = intMetadataClass.newDate
                        aReturn = AdiwgDateTimeFun.dateTimeFromString(hSbDate['dateString'])
                        unless aReturn.nil?
                           hDate[:date] = aReturn[0]
                           hDate[:dateResolution] = aReturn[1]
                           hDate[:description] = hSbDate['label']
                           type = @Namespace::Codelists.codelist_iso_to_sb('iso_sb_date', :sbCode => hSbDate['type'])
                           type = type.nil? ? hSbDate['type'] : type
                           hDate[:dateType] = type
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
