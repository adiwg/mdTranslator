# ISO <<Class>> MD_ReferenceSystem
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-09-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_referenceIdentifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_ReferenceSystem

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(refSystem, refType)

                        # classes used
                        refIdClass = $IsoNS::RS_Identifier.new(@xml)

                        @xml.tag!('gmd:MD_ReferenceSystem') do
                            @xml.tag!('gmd:referenceSystemIdentifier') do
                                refIdClass.writeXML(refSystem, refType)
                            end
                        end

                    end

                end

            end
        end
    end
end
