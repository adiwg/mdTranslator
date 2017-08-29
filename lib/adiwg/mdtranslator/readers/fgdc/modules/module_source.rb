# Reader - fgdc to internal data structure
# unpack fgdc source

# History:
#  Stan Smith 2017-08-28 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Source

               def self.unpack(xSource, aSpatialResolutions, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hSource = intMetadataClass.newDataSource

                  # source 2.5.1.1 (srccite) - source citation {citation}
                  xCitation = xSource.xpath('./srccite')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     hSource[:sourceCitation] = hCitation
                  end

                  # source 2.5.1.2 (srcscale) - source scale denominator
                  scale = xSource.xpath('./srcscale').text
                  unless scale.empty?
                     hResolution = intMetadataClass.newSpatialResolution
                     hResolution[:scaleFactor] = scale.to_i
                     aSpatialResolutions << hResolution
                  end

                  # source 2.5.1.3 (typesrc) - type of source media
                  type = xSource.xpath('./typesrc').text
                  unless type.empty?
                     hSource[:description] = type
                  end

                  # source 2.5.1.4 (srctime) - source time period {scope < temporalExtent}
                  xTimePeriod = xSource.xpath('./srctime')
                  unless xTimePeriod.empty?
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     unless hTimePeriod.nil?
                        hScope = intMetadataClass.newScope
                        hExtent = intMetadataClass.newExtent
                        hTempExtent = intMetadataClass.newTemporalExtent
                        hTempExtent[:timePeriod] = hTimePeriod
                        hExtent[:temporalExtents] << hTempExtent
                        if hSource[:description].nil?
                           hScope[:scopeCode] = 'dataset'
                        else
                           hScope[:scopeCode] = hSource[:description] = type
                        end
                        hScope[:extents] << hExtent
                        hSource[:scope] = hScope
                     end
                  end

                  # source 2.5.1.5 (srccitea) - source citation abbreviation
                  citationAbb = xSource.xpath('./srccitea').text
                  unless citationAbb.empty?
                     hSource[:sourceCitation][:alternateTitles] << citationAbb
                  end

                  # source 2.5.1.6 (srccontr) - source contribution
                  contribution = xSource.xpath('./srccontr').text
                  unless contribution.empty?
                     hSource[:description] = contribution
                  end

                  return hSource

               end

            end

         end
      end
   end
end
