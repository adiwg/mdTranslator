# ISO <<Class>> MD_Georeferenceable
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_grid'
require_relative 'class_citation'
require_relative 'class_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Georeferenceable

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hGeoRef, inContext = nil)

                  # classes used
                  gridClass = Grid.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)


                  outContext = 'georeferenceable representation'
                  outContext = inContext + ' georeferenceable representation' unless inContext.nil?

                  @xml.tag!('msr:MD_Georeferenceable') do

                     # georeferenceable - scope
                     hGeoRef[:scope].each do |scope|
                        @xml.tag!('msr:scope') do
                           scopeClass.writeXML(scope, inContext)
                        end
                     end

                     # georeferenceable - add grid info (required)
                     hGrid = hGeoRef[:gridRepresentation]
                     gridClass.writeXML(hGrid, outContext)

                     # georeferenceable - control point availability (required)
                     @xml.tag!('msr:controlPointAvailability') do
                        @xml.tag!('gco:Boolean', hGeoRef[:orientationParameterAvailable])
                     end

                     # georeferenceable - orientation parameter availability (required)
                     @xml.tag!('msr:orientationParameterAvailability') do
                        @xml.tag!('gco:Boolean', hGeoRef[:orientationParameterAvailable])
                     end

                     # georeferenceable - orientation parameter description
                     unless hGeoRef[:orientationParameterDescription].nil?
                        @xml.tag!('msr:orientationParameterDescription') do
                           @xml.tag!('gco:CharacterString', hGeoRef[:orientationParameterDescription])
                        end
                     end
                     if hGeoRef[:orientationParameterDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:orientationParameterDescription')
                     end

                     # georeferenceable - georeferenced parameter (required)
                     unless hGeoRef[:georeferencedParameter].nil?
                        @xml.tag!('msr:georeferencedParameters') do
                           @xml.tag!('gco:Record', hGeoRef[:georeferencedParameter])
                        end
                     end
                     if hGeoRef[:georeferencedParameter].nil?
                        @NameSpace.issueWarning(180, 'msr:georeferencedParameters', outContext)
                     end

                     # georeferenceable - parameter citation [] {citation}
                     aCitation = hGeoRef[:parameterCitation]
                     aCitation.each do |hCitation|
                        @xml.tag!('msr:parameterCitation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:parameterCitation')
                     end

                  end # msr:MD_Georeferenceable tag
               end # writeXML
            end # MD_Georeferenceable class

         end
      end
   end
end
