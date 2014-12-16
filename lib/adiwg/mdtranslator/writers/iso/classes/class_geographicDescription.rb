# ISO <<Class>> EX_GeographicDescription
# writer output in XML

# History:
# 	Stan Smith 2013-06-03 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_identifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class EX_GeographicDescription

    def initialize(xml)
        @xml = xml
    end

    def writeXML(hElement)

        # classes used
        idClass = $WriterNS::MD_Identifier.new(@xml)

        @xml.tag!('gmd:EX_GeographicDescription') do
            @xml.tag!('gmd:geographicIdentifier') do
                idClass.writeXML(hElement)
            end
        end

    end

                end

            end
        end
    end
end
