# ISO <<Class>> MD_ReferenceSystem
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-09-03 original script

require 'class_referenceIdentifier'

class MD_ReferenceSystem

    def initialize(xml)
        @xml = xml
    end

    def writeXML(refSystem, refType)

        # classes used by MD_Metadata
        refIdClass = RS_Identifier.new(@xml)

        @xml.tag!('gmd:MD_ReferenceSystem') do
            @xml.tag!('gmd:referenceSystemIdentifier') do
                refIdClass.writeXML(refSystem, refType)
            end
        end

    end

end