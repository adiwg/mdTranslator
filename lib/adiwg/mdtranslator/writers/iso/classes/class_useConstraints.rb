# ISO <<Class>> MD_Constraints
# writer output in XML

# History:
# 	Stan Smith 2013-10-31 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Constraints

                    def initialize(xml)
                        @xml = xml
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
