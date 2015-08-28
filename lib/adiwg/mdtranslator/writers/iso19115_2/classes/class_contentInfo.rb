# ISO <<abstract class>> ContentInfo
# writer output in XML

# History:
# 	Stan Smith 2015-08-27 original script.

require_relative 'class_codelist'
require_relative 'class_band'
require_relative 'class_imageDescription'
require_relative 'class_rangeElementDescription'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class ContentInfo

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hContent)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        bandClass = MD_Band.new(@xml, @responseObj)
                        imageClass = ImageDescription.new(@xml, @responseObj)
                        rangeClass = MI_RangeElementDescription.new(@xml, @responseObj)

                        if !hContent[:imageInfo].empty?
                            contentTag = 'gmi:MI_ImageDescription'
                        else
                            contentTag = 'gmi:MI_CoverageDescription'
                        end

                        @xml.tag!(contentTag) do

                            # content information - attribute description - required
                            # combine coverageName and coverageDescription
                            attDesc = ''
                            if hContent[:coverageName]
                                attDesc += hContent[:coverageName] + '; '
                            end
                            if hContent[:coverageDescription]
                                attDesc += hContent[:coverageDescription]
                            end
                            if attDesc == ''
                                @xml.tag!('gmd:attributeDescription', {'gco:nilReason'=>'missing'})
                            else
                                @xml.tag!('gmd:attributeDescription') do
                                    @xml.tag!('gco:RecordType', attDesc)
                                end
                            end

                            # content information - content type - required - MD_CoverageContentTypeCode
                            s = hContent[:coverageType]
                            if !s.nil?
                                @xml.tag!('gmd:contentType') do
                                    codelistClass.writeXML('iso_coverageContentType',s)
                                end
                            else
                                @xml.tag!('gmd:contentType', {'gco:nilReason'=>'missing'})
                            end

                            # content information - coverage items [] - band information
                            # only write band information if applicable coverage items are present
                            aCoverItems = hContent[:coverageItems]
                            aCoverItems.each do |hCoverItem|

                                # check for applicable coverage items
                                if  !hCoverItem[:maxValue].nil? ||
                                    !hCoverItem[:minValue].nil? ||
                                    !hCoverItem[:units].nil? ||
                                    !hCoverItem[:bitsPerValue].nil? ||
                                    !hCoverItem[:scaleFactor].nil? ||
                                    !hCoverItem[:offset].nil?
                                    @xml.tag!('gmd:dimension') do
                                        bandClass.writeXML(hCoverItem)
                                    end
                                end

                            end

                            # content information - image information
                            # pass whole content information object
                            if !hContent[:imageInfo].empty?
                                imageClass.writeXML(hContent)
                            end

                            # content information - coverage items [] - classified data
                            aCoverItems = hContent[:coverageItems]
                            aCoverItems.each do |hCoverItem|
                                if !hCoverItem[:classedData].empty?
                                    @xml.tag!('gmi:rangeElementDescription') do
                                        rangeClass.writeXML(hCoverItem)
                                    end
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
