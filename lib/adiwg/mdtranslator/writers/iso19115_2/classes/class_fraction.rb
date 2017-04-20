# ISO <<Class>> MD_RepresentativeFraction
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_RepresentativeFraction

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(denominator)

                        @xml.tag!('gmd:MD_RepresentativeFraction') do

                            # representative fraction - denominator
                            unless denominator.nil?
                                @xml.tag!('gmd:denominator') do
                                    @xml.tag!('gco:Integer', denominator)
                                end
                            end
                            if denominator.nil?
                                @xml.tag!('gmd:denominator', {'gco:nilReason' => 'missing'})
                            end

                        end # gmd:MD_RepresentativeFraction tag
                    end # writeXML
                end # MD_RepresentativeFraction class

            end
        end
    end
end
