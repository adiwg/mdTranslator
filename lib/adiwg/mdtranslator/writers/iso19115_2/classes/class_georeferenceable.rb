# ISO <<Class>> MD_Georeferenceable
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2016-12-08 original script.

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
                    end

                    def writeXML(hGrid)

                        # classes used
                        gridClass = Grid.new(@xml, @hResponseObj)
                        citationClass = CI_Citation.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_Georeferenceable') do

                            # georeferenceable - add grid info
                            gridClass.writeXML(hGrid)

                            # georeferenceable - control point availability
                            s = hGrid[:controlPointAvailability]
                            @xml.tag!('gmd:controlPointAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end

                            # georeferenceable - orientation parameter availability
                            s = hGrid[:orientationParameterAvailability]
                            @xml.tag!('gmd:orientationParameterAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end

                            # georeferenceable - orientation parameter description
                            s = hGrid[:orientationParameterDescription]
                            unless s.nil?
                                @xml.tag!('gmd:orientationParameterDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:orientationParameterDescription')
                            end

                            # georeferenceable - georeferenced parameter
                            s = hGrid[:georeferencedParameter]
                            unless s.nil?
                                @xml.tag!('gmd:georeferencedParameter') do
                                    @xml.tag!('gco:Record', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:georeferencedParameter')
                            end

                            # georeferenceable - parameter citation [{citation}]
                            aCitation = hGrid[:parameterCitation]
                            aCitation.each do |hCitation|
                                @xml.tag!('gmd:parameterCitation') do
                                    citationClass.writeXML(hCitation)
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
