# ISO <<Class>> MD_SecurityConstraints
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'code_classification'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_SecurityConstraints

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hSecurityCons)

                        # classes used
                        classCode = $WriterNS::MD_ClassificationCode.new(@xml)

                        @xml.tag!('gmd:MD_SecurityConstraints') do

                            # security constraints - classification code - required
                            s = hSecurityCons[:classCode]
                            if s.nil?
                                @xml.tag!('gmd:classification', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:classification') do
                                    classCode.writeXML(s)
                                end
                            end

                            # security constraints - user note
                            s = hSecurityCons[:userNote]
                            if !s.nil?
                                @xml.tag!('gmd:userNote') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:userNote')
                            end

                            # security constraints - classification system
                            s = hSecurityCons[:classSystem]

                            if !s.nil?
                                @xml.tag!('gmd:classificationSystem') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:classificationSystem')
                            end

                            # security constraints - handling description
                            s = hSecurityCons[:handlingDesc]
                            if !s.nil?
                                @xml.tag!('gmd:handlingDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:handlingDescription')
                            end

                        end

                    end

                end

            end
        end
    end
end
