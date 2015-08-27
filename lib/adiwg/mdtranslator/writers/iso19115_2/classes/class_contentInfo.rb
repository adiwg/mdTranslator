# ISO <<Class>> MD_ContentInformation <<abstract class>>
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_ContentInformation

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hCoverInfo)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_SecurityConstraints') do

                            # security constraints - classification code - required
                            s = hSecurityCons[:classCode]
                            if s.nil?
                                @xml.tag!('gmd:classification', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:classification') do
                                    codelistClass.writeXML('iso_classification',s)
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
