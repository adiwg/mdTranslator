# ISO <<Class>> MD_Medium
# writer output in XML

# History:
# 	Stan Smith 2013-09-26 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'code_mediumName'
require 'code_mediumFormat'

class MD_Medium

    def initialize(xml)
        @xml = xml
    end

    def writeXML(medium)

        # classes used
        medFormatCode = MD_MediumFormatCode.new(@xml)
        medNameCode = MD_MediumNameCode.new(@xml)

        @xml.tag!('gmd:MD_Medium') do

            # medium - name - MD_MediumNameCode
            s = medium[:mediumName]
            if !s.nil?
                @xml.tag!('gmd:name') do
                    medNameCode.writeXML(s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:name')
            end

            # medium - medium format - MD_MediumFormatCode
            s = medium[:mediumFormat]
            if !s.nil?
                @xml.tag!('gmd:mediumFormat') do
                    medFormatCode.writeXML(s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:mediumFormat')
            end

            # medium - medium note
            s = medium[:mediumNote]
            if !s.nil?
                @xml.tag!('gmd:mediumNote') do
                    @xml.tag!('gco:CharacterString', s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:mediumNote')
            end

        end

    end

end
