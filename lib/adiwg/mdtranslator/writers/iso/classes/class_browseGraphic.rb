# ISO <<Class>> MD_BrowseGraphic
# writer output in XML

# History:
# 	Stan Smith 2013-10-17 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_BrowseGraphic

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(graphic)

                        @xml.tag!('gmd:MD_BrowseGraphic') do

                            # browse graphic - file name - required
                            s = graphic[:bGName]
                            if !s.nil?
                                @xml.tag!('gmd:fileName') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:fileName')
                            end

                            # browse graphic - file description
                            s = graphic[:bGDescription]
                            if !s.nil?
                                @xml.tag!('gmd:fileDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:fileDescription')
                            end

                            # browse graphic - file type
                            s = graphic[:bGType]
                            if !s.nil?
                                @xml.tag!('gmd:fileType') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:fileType')
                            end

                        end

                    end

                end

            end
        end
    end
end
