# ISO <<Class>> MD_Constraints
# writer output in XML

# History:
# 	Stan Smith 2013-10-31 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Constraints

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(aUseCons)

                        @xml.tag!('gmd:MD_Constraints') do

                            aUseCons.each do |useCon|

                                # use constraints - required
                                @xml.tag!('gmd:useLimitation') do
                                    @xml.tag!('gco:CharacterString', useCon)
                                end

                            end

                        end

                    end

                end

            end
        end
    end
end
