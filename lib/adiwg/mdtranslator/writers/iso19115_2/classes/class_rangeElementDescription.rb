# ISO <<Class>> MI_RangeElementDescription
# writer output in XML

# History:
# 	Stan Smith 2015-08-28 original script.

require_relative 'class_resourceIdentifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MI_RangeElementDescription

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hCoverItem)

                        # classes used
                        resIdClass = RS_Identifier.new(@xml, @responseObj)

                        hClass = hCoverItem[:classedData]

                        @xml.tag!('gmi:MI_RangeElementDescription') do

                            # range element description - name - required
                            s = hCoverItem[:itemName]
                            if !s.nil?
                                @xml.tag!('gmi:name') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gmi:name', {'gco:nilReason'=>'missing'})
                            end

                            # range element description - definition - required
                            s = hCoverItem[:itemDescription]
                            if !s.nil?
                                @xml.tag!('gmi:definition') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gmi:definition', {'gco:nilReason'=>'missing'})
                            end

                            # range element description - range element - required
                            if !hClass.empty?
                                aElements = hClass[:classedDataItems]
                                if aElements.length > 0
                                    aElements.each do |hElement|

                                        # convert element to RS_Identifier
                                        intMetadataClass = InternalMetadata.new
                                        hResId = intMetadataClass.newResourceId
                                        hCitation = intMetadataClass.newCitation

                                        hCitation[:citTitle] = hElement[:className]
                                        hCitation[:citAltTitle] = hElement[:classDescription]
                                        hResId[:identifier] = hElement[:classValue]
                                        hResId[:identifierCitation] = hCitation

                                        @xml.tag!('gmi:rangeElement') do
                                            @xml.tag!('gco:Record') do
                                                resIdClass.writeXML(hResId)
                                            end
                                        end

                                    end
                                else
                                    @xml.tag!('gmi:rangeElement', {'gco:nilReason'=>'missing'})
                                end
                            end


                        end

                    end

                end

            end
        end
    end
end
