# ISO <<Class>> MD_Band
# writer output in XML

# History:
# 	Stan Smith 2015-08-27 original script.

require_relative 'class_unitsOfMeasure'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Band

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hBand)

                        # classes used
                        uomClass = UnitsOfMeasure.new(@xml, @responseObj)

                        hSensor = hBand[:sensorInfo]

                        @xml.tag!('gmd:MD_Band') do

                            # band name and type are embedded in sequenceIdentifier
                            # neither are required
                            if hBand[:itemName] or hBand[:itemType]
                                @xml.tag!('gmd:sequenceIdentifier') do
                                    @xml.tag!('gco:MemberName') do

                                        # band - name
                                        s = hBand[:itemName]
                                        if !s.nil?
                                            @xml.tag!('gco:aName') do
                                                @xml.tag!('gco:CharacterString', s)
                                            end
                                        elsif @responseObj[:writerShowTags]
                                            @xml.tag!('gco:aName')
                                        end

                                        # band - attribute type
                                        s = hBand[:itemType]
                                        if !s.nil?
                                            @xml.tag!('gco:attributeType') do
                                                @xml.tag!('gco:TypeName') do
                                                    @xml.tag!('gco:aName') do
                                                        @xml.tag!('gco:CharacterString', s)
                                                    end
                                                end
                                            end
                                        elsif @responseObj[:writerShowTags]
                                            @xml.tag!('gco:attributeType')
                                        end

                                    end
                                end
                            end

                            # band - descriptor
                            s = hBand[:itemDescription]
                            if !s.nil?
                                @xml.tag!('gmd:descriptor') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:descriptor')
                            end

                            # band - max value
                            s = hBand[:maxValue]
                            if !s.nil?
                                @xml.tag!('gmd:maxValue') do
                                    @xml.tag!('gco:Real', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:maxValue')
                            end

                            # band - min value
                            s = hBand[:minValue]
                            if !s.nil?
                                @xml.tag!('gmd:minValue') do
                                    @xml.tag!('gco:Real', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:minValue')
                            end

                            # band - units
                            s = hBand[:units]
                            if !s.nil?
                                @xml.tag!('gmd:units') do
                                    uomClass.writeUnits(s)
                                end
                            end

                            # band - peak response (from sensorInfo object)
                            if !hSensor.empty?
                                s = hSensor[:sensorPeakResponse]
                                if !s.nil?
                                    @xml.tag!('gmd:peakResponse') do
                                        @xml.tag!('gco:Real', s)
                                    end
                                elsif @responseObj[:writerShowTags]
                                    @xml.tag!('gmd:peakResponse')
                                end
                            end

                            # band - bits per value
                            s = hBand[:bitsPerValue]
                            if !s.nil?
                                @xml.tag!('gmd:bitsPerValue') do
                                    @xml.tag!('gco:Integer', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:bitsPerValue')
                            end

                            # band - tone gradation (from sensorInfo object)
                            if !hSensor.empty?
                                s = hSensor[:toneGradations]
                                if !s.nil?
                                    @xml.tag!('gmd:toneGradation') do
                                        @xml.tag!('gco:Integer', s)
                                    end
                                elsif @responseObj[:writerShowTags]
                                    @xml.tag!('gmd:toneGradation')
                                end
                            end

                            # band - scale factor
                            s = hBand[:scaleFactor]
                            if !s.nil?
                                @xml.tag!('gmd:scaleFactor') do
                                    @xml.tag!('gco:Real', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:scaleFactor')
                            end

                            # band - offset
                            s = hBand[:offset]
                            if !s.nil?
                                @xml.tag!('gmd:offset') do
                                    @xml.tag!('gco:Real', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:offset')
                            end

                        end

                    end

                end

            end
        end
    end
end
