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

               def self.unpack(xSource, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hSource = intMetadataClass.newDataSource

                  # source 2.5.1.1 (srccite) - source citation {citation} (required)
                  xCitation = xSource.xpath('./srccite')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     hSource[:sourceCitation] = hCitation
                  end
                  if xCitation.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: lineage source citation is missing'
                  end

                  # source 2.5.1.2 (srcscale) - source scale denominator
                  scale = xSource.xpath('./srcscale').text
                  unless scale.empty?
                     hResolution = intMetadataClass.newSpatialResolution
                     hResolution[:scaleFactor] = scale.to_i
                     hSource[:spatialResolution] = hResolution
                  end

                  # source 2.5.1.3 (typesrc) - type of source media (required)
                  type = xSource.xpath('./typesrc').text
                  unless type.empty?
                     hSource[:description] = type
                  end
                  if type.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: lineage source media type is missing'
                  end

                  # source 2.5.1.4 (srctime) - source time period {scope < temporalExtent} (required)
                  xTimePeriod = xSource.xpath('./srctime')
                  unless xTimePeriod.empty?
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     unless hTimePeriod.nil?
                        hScope = intMetadataClass.newScope
                        hExtent = intMetadataClass.newExtent
                        hTempExtent = intMetadataClass.newTemporalExtent
                        hTempExtent[:timePeriod] = hTimePeriod
                        hExtent[:temporalExtents] << hTempExtent
                        hScope[:scopeCode] = 'dataset'
                        hScope[:extents] << hExtent
                        hSource[:scope] = hScope
                     end
                  end
                  if xTimePeriod.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: lineage source time period is missing'
                  end

                  # source 2.5.1.5 (srccitea) - source citation abbreviation (required)
                  sourceAbb = xSource.xpath('./srccitea').text
                  unless sourceAbb.empty?
                     hSource[:sourceId] = sourceAbb
                  end
                  if sourceAbb.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: lineage source citation abbreviation is missing'
                  end

                  # source 2.5.1.6 (srccontr) - source contribution (required)
                  contribution = xSource.xpath('./srccontr').text
                  unless contribution.empty?
                     hSource[:description] = contribution
                  end
                  if contribution.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: lineage source contribution is missing'
                  end

                  return hSource

               end

            end

         end
      end
   end
end
