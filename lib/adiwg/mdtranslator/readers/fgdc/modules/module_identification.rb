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

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

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

                     # time period for single date and date range
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     unless hTimePeriod.nil?
                        hResourceInfo[:timePeriod] = hTimePeriod
                     end

                     # time period multiple date time pairs 9.1.2 (mdattim)
                     axMultiple = xTimePeriod.xpath('./timeinfo/mdattim/sngdate')
                     unless axMultiple.empty?
                        hExtent = intMetadataClass.newExtent
                        hExtent[:description] = 'FGDC resource time period multiple date/times'
                        axMultiple.each do |xDateTime|
                           date = xDateTime.xpath('./caldate').text
                           time = xDateTime.xpath('./time').text
                           hInstant = TimeInstant.unpack(date, time, hResponseObj)
                           unless hInstant.nil?
                              hTempExtent = intMetadataClass.newTemporalExtent
                              hInstant[:description] = 'Resource period instant'
                              hTempExtent[:timeInstant] = hInstant
                              hExtent[:temporalExtents] << hTempExtent
                           end
                        end
                        unless hExtent[:temporalExtents].empty?
                           hResourceInfo[:extents] << hExtent
                        end
                     end

                  end

               end

            end

         end
      end
   end
end
