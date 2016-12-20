# ISO <<abstract class>> CoverageDescription
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-23 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

require_relative 'class_codelist'
require_relative 'class_attributeGroup'
require_relative 'class_image'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class CoverageDescription

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hCoverage)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        attGroupClass = AttributeGroup.new(@xml, @hResponseObj)
                        imageClass = MI_ImageDescription.new(@xml, @hResponseObj)

                        # determine type of MD_CoverageDescription to write
                        if hCoverage[:imageDescription].empty?
                            contentTag = 'gmi:MI_CoverageDescription'
                        else
                            contentTag = 'gmi:MI_ImageDescription'
                        end

                        @xml.tag!(contentTag) do

                            # coverage description - attribute description (required)
                            # combine coverageName and coverageDescription
                            attDesc = ''
                            unless hCoverage[:coverageName].nil?
                                attDesc += hCoverage[:coverageName] + '; '
                            end
                            unless hCoverage[:coverageDescription].nil?
                                attDesc += hCoverage[:coverageDescription]
                            end
                            unless attDesc == ''
                                @xml.tag!('gmd:attributeDescription') do
                                    @xml.tag!('gco:RecordType', attDesc)
                                end
                            end
                            if attDesc == ''
                                @xml.tag!('gmd:attributeDescription', {'gco:nilReason'=>'missing'})
                            end

                            # coverage description - content type (required) {MD_CoverageContentTypeCode}
                            aGroups = hCoverage[:attributeGroups]
                            s = nil
                            unless aGroups.empty?
                                s = aGroups[0][:attributeContentTypes][0]
                                unless s.nil?
                                    @xml.tag!('gmd:contentType') do
                                        codelistClass.writeXML('gmd', 'iso_coverageContentType',s)
                                    end
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:contentType', {'gco:nilReason'=>'missing'})
                            end

                            # coverage description - dimension []
                            aGroups.each do |hGroup|
                                aAttributes = hGroup[:attributes]
                                aAttributes.each do |hAttributes|
                                    @xml.tag!('gmd:dimension') do
                                        attGroupClass.writeXML(hAttributes)
                                    end
                                end
                            end
                            if aGroups.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:dimension')
                            end

                            # coverage description - image information
                            hImage = hCoverage[:imageDescription]
                            unless hImage.empty?
                                imageClass.writeXML(hCoverage)
                            end

                        end # MI_CoverageDescription/MI_ImageDescription tag
                    end # writeXML
                end # ContentInformation class

            end
        end
    end
end
