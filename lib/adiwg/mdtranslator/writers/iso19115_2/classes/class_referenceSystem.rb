# ISO <<Class>> MD_ReferenceSystem
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
#   Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-08-28 convert referenceSystem to resourceId and pass to RS_Identifier
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-09-03 original script

require_relative 'class_rsIdentifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_ReferenceSystem

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hSystem)

                        # classes used
                        idClass =  RS_Identifier.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_ReferenceSystem') do
                            @xml.tag!('gmd:referenceSystemIdentifier') do
                                idClass.writeXML(hSystem)
                            end
                        end

                    end # writeXML
                end # MD_ReferenceSystem class

            end
        end
    end
end
