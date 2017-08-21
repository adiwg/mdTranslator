# Reader - fgdc to internal data structure
# unpack fgdc metadata identification

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'
require_relative 'module_timePeriod'
require_relative 'module_timeInstant'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Identification

               def self.unpack(xIdInfo, intObj, hResponseObj)

                  # useful parts
                  hMetadata = intObj[:metadata]
                  hMetadataInfo = hMetadata[:metadataInfo]
                  hResourceInfo = hMetadata[:resourceInfo]

                  # identification information 1.1 (citation) - citation (required)
                  xCitation = xIdInfo.xpath('./citation')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     unless hCitation.nil?
                        hResourceInfo[:citation] = hCitation
                     end
                  end

                  # identification information 1.2 (descript) - description (required)
                  xDescription = xIdInfo.xpath('./descript')
                  unless xDescription.empty?

                     # description 1.2.1 (abstract) - abstract
                     abstract = xDescription.xpath('./abstract').text
                     unless abstract.empty?
                        hResourceInfo[:abstract] = abstract
                     end

                     # description 1.2.2 (purpose) - purpose
                     purpose = xDescription.xpath('./purpose').text
                     unless purpose.empty?
                        hResourceInfo[:purpose] = purpose
                     end

                     # description 1.2.3 (supplinf) - supplemental information
                     supplemental = xDescription.xpath('./supplinf').text
                     unless supplemental.empty?
                        hResourceInfo[:supplementalInfo] = supplemental
                     end

                  end

                  # identification information 1.3 (timeperd) - time period of content
                  xTimePeriod = xIdInfo.xpath('./timeperd')
                  unless xTimePeriod.empty?

                     # for single date and range of dates
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     unless hTimePeriod.nil?
                        hResourceInfo[:timePeriod] = hTimePeriod
                     end

                     # multiple date time pairs
                     xMultiple = xTimePeriod.xpath('./mdattime')
                     unless xMultiple.empty?
                        xMultiple.each do |xDateTime|
                           a=1
                        end
                     end

                  end

               end

            end

         end
      end
   end
end
