# FGDC <<Class>> Source
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-12-18 original script

require_relative '../fgdc_writer'
require_relative 'class_citation'
require_relative 'class_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Source

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hSource, aSourceCollection)
                  
                  # skip if this source is already identified
                  unless hSource[:sourceId].nil?
                     return if aSourceCollection.include?(hSource[:sourceId])
                     aSourceCollection << hSource[:sourceId]
                  end
                  if hSource[:sourceId].nil?
                     @NameSpace.issueError(230)
                  end

                  @xml.tag!('srcinfo') do

                     # classes used
                     citationClass = Citation.new(@xml, @hResponseObj)
                     timePeriodClass = TimePeriod.new(@xml, @hResponseObj)

                     # source 2.5.1.1 (srccite) - source citation (required)
                     # <- resourceLineage.source.sourceCitation
                     unless hSource[:sourceCitation].empty?
                        @xml.tag!('srccite') do
                           citationClass.writeXML(hSource[:sourceCitation], [], 'lineage source')
                        end
                     end
                     if hSource[:sourceCitation].empty?
                        @NameSpace.issueWarning(231, nil, "source ID #{hSource[:sourceId]}")
                     end

                     # source 2.5.1.2 (srcscale) - source scale denominator
                     # <- resourceLineage.source.spatialResolution.scaleFactor
                     haveResolution = false
                     unless hSource[:spatialResolution].empty?
                        unless hSource[:spatialResolution].nil?
                           haveResolution = true
                           @xml.tag!('srcscale', hSource[:spatialResolution][:scaleFactor].to_s)
                        end
                     end
                     if !haveResolution && @hResponseObj[:writerShowTags]
                        @xml.tag!('srcscale')
                     end

                     # source 2.5.1.3 (typesrc) - type of source media (required)
                     # <- resourceLineage.source.description
                     unless hSource[:description].nil?
                        @xml.tag!('typesrc', hSource[:description])
                     end
                     if hSource[:description].nil?
                        @NameSpace.issueWarning(232, 'typesrc', "source ID #{hSource[:sourceId]}")
                     end

                     # source 2.5.1.4 (srctime) - source time period (required)
                     # <- resourceLineage.source.scope.extents[0].temporalExtent[0].timePeriod
                     haveTime = false
                     unless hSource[:scope].empty?
                        unless hSource[:scope][:extents].empty?
                           unless hSource[:scope][:extents][0][:temporalExtents].empty?
                              unless hSource[:scope][:extents][0][:temporalExtents][0][:timePeriod].empty?
                                 haveTime = true
                                 hTimePeriod = hSource[:scope][:extents][0][:temporalExtents][0][:timePeriod]
                                 @xml.tag!('srctime') do
                                    timePeriodClass.writeXML(hTimePeriod, 'srccurr')
                                 end
                              end
                           end
                        end
                     end
                     unless haveTime
                        @NameSpace.issueWarning(233, nil, "source ID #{hSource[:sourceId]}")
                     end

                     # source 2.5.1.5 (srccitea) - source citation abbreviation (required)
                     # <- resourceLineage.source.sourceId
                     unless hSource[:sourceId].nil?
                        @xml.tag!('srccitea', hSource[:sourceId])
                     end
                     if hSource[:sourceId].nil?
                        @NameSpace.issueWarning(234, 'srccitea', "source ID #{hSource[:sourceId]}")
                     end

                     # source 2.5.1.6 (srccontr) - source contribution (required)
                     # <- resourceLineage.source.description
                     unless hSource[:description].nil?
                        @xml.tag!('srccontr', hSource[:description])
                     end
                     if hSource[:description].nil?
                        @NameSpace.issueWarning(235, 'srccontr', "source ID #{hSource[:sourceId]}")
                     end

                  end

               end # writeXML
            end # Source

         end
      end
   end
end
