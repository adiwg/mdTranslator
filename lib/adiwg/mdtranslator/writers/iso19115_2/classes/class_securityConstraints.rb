# ISO <<Class>> MD_SecurityConstraints
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_SecurityConstraints

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hSecurityCons)

                        # classes used
                        codelistClass = $IsoNS::MD_Codelist.new(@xml, @responseObj)

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

                            # security constraints - user note
                            s = hSecurityCons[:userNote]
                            if !s.nil?
                                @xml.tag!('gmd:userNote') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:userNote')
                            end

                            # security constraints - classification system
                            s = hSecurityCons[:classSystem]

                            if !s.nil?
                                @xml.tag!('gmd:classificationSystem') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:classificationSystem')
                            end

                            # security constraints - handling description
                            s = hSecurityCons[:handlingDesc]
                            if !s.nil?
                                @xml.tag!('gmd:handlingDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:handlingDescription')
                            end

                        end

                    end

                end

            end
        end
    end
end
