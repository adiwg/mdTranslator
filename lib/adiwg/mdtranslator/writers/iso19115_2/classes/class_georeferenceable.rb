# ISO <<Class>> MD_Georeferenceable
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
# 	Stan Smith 2016-12-08 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_grid'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Georeferenceable

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hGeoRef)

                  # classes used
                  gridClass = Grid.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Georeferenceable') do

                     # georeferenceable - add grid info (required)
                     hGrid = hGeoRef[:gridRepresentation]
                     gridClass.writeXML(hGrid, 'georeferenceable representation')

                     # georeferenceable - control point availability (required)
                     s = hGeoRef[:orientationParameterAvailable]
                     @xml.tag!('gmd:controlPointAvailability') do
                        @xml.tag!('gco:Boolean', s)
                     end

                     # georeferenceable - orientation parameter availability (required)
                     s = hGeoRef[:orientationParameterAvailable]
                     @xml.tag!('gmd:orientationParameterAvailability') do
                        @xml.tag!('gco:Boolean', s)
                     end

                     # georeferenceable - orientation parameter description
                     s = hGeoRef[:orientationParameterDescription]
                     unless s.nil?
                        @xml.tag!('gmd:orientationParameterDescription') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:orientationParameterDescription')
                     end

                     # georeferenceable - georeferenced parameter (required)
                     s = hGeoRef[:georeferencedParameter]
                     unless s.nil?
                        @xml.tag!('gmd:georeferencedParameters') do
                           @xml.tag!('gco:Record', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(180, 'gmd:georeferencedParameters', 'spatial representation')
                     end

                     # georeferenceable - parameter citation [{citation}]
                     aCitation = hGeoRef[:parameterCitation]
                     aCitation.each do |hCitation|
                        @xml.tag!('gmd:parameterCitation') do
                           citationClass.writeXML(hCitation, 'georeferenceable representation')
                        end
                     end
                     if aCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:parameterCitation')
                     end

                  end # gmd:MD_Georeferenceable tag
               end # writeXML
            end # MD_Georeferenceable class

         end
      end
   end
end
