# ISO <<Class>> MD_LegalConstraints
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_LegalConstraints

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hLegalCons)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_LegalConstraints') do

                            # legal constraints - access constraints
                            aAccessCodes = hLegalCons[:accessCodes]
                            if !aAccessCodes.empty?
                                aAccessCodes.each do |code|
                                    @xml.tag!('gmd:accessConstraints') do
                                        codelistClass.writeXML('iso_restriction',code)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:accessConstraints')
                            end

                            # legal constraints - use constraints
                            aUseCodes = hLegalCons[:useCodes]
                            if !aUseCodes.empty?
                                aUseCodes.each do |code|
                                    @xml.tag!('gmd:useConstraints') do
                                        codelistClass.writeXML('iso_restriction',code)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:useConstraints')
                            end

                            # legal constraints - other constraints
                            aOtherCons = hLegalCons[:otherCons]
                            if !aOtherCons.empty?
                                aOtherCons.each do |con|
                                    @xml.tag!('gmd:otherConstraints') do
                                        @xml.tag!('gco:CharacterString', con)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:otherConstraints')
                            end

                        end

                    end

                end

            end
        end
    end
end
