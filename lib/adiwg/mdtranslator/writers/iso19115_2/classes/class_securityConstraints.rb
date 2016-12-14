# ISO <<Class>> MD_SecurityConstraints
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-01 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_SecurityConstraints

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hConstraint)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_SecurityConstraints') do

                            # legal constraints - use limitation [] (required)
                            hUse = hConstraint[:constraint]
                            unless hUse.empty?
                                aCons = hUse[:useLimitation]
                                aCons.each do |useCon|
                                    @xml.tag!('gmd:useLimitation') do
                                        @xml.tag!('gco:CharacterString', useCon)
                                    end
                                end
                            end
                            if hUse.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:useLimitation')
                            end

                            # security constraints - classification code (required)
                            s = hConstraint[:classCode]
                            unless s.nil?
                                @xml.tag!('gmd:classification') do
                                    codelistClass.writeXML('iso_classification',s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:classification', {'gco:nilReason' => 'missing'})
                            end

                            # security constraints - user note
                            s = hConstraint[:userNote]
                            unless s.nil?
                                @xml.tag!('gmd:userNote') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:userNote')
                            end

                            # security constraints - classification system
                            s = hConstraint[:classSystem]
                            unless s.nil?
                                @xml.tag!('gmd:classificationSystem') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:classificationSystem')
                            end

                            # security constraints - handling description
                            s = hConstraint[:handlingDesc]
                            unless s.nil?
                                @xml.tag!('gmd:handlingDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:handlingDescription')
                            end

                        end
                    end
                end

            end
        end
    end
end
