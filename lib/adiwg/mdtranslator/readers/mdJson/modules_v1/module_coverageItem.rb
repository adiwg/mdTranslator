# unpack coverage item
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_sensorInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_classedData')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module CoverageItem

                    def self.unpack(hCoverItem, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hCovItem = intMetadataClass.newCoverageItem

                        # coverage item - item name
                        if hCoverItem.has_key?('itemName')
                            s = hCoverItem['itemName']
                            if s != ''
                                hCovItem[:itemName] = s
                            end
                        end

                        # coverage item - item type
                        if hCoverItem.has_key?('itemType')
                            s = hCoverItem['itemType']
                            if s != ''
                                hCovItem[:itemType] = s
                            end
                        end

                        # coverage item - item description
                        if hCoverItem.has_key?('itemDescription')
                            s = hCoverItem['itemDescription']
                            if s != ''
                                hCovItem[:itemDescription] = s
                            end
                        end

                        # coverage item - minimum value
                        if hCoverItem.has_key?('minValue')
                            s = hCoverItem['minValue']
                            if s != ''
                                hCovItem[:minValue] = s
                            end
                        end

                        # coverage item - maximum value
                        if hCoverItem.has_key?('maxValue')
                            s = hCoverItem['maxValue']
                            if s != ''
                                hCovItem[:maxValue] = s
                            end
                        end

                        # coverage item - value units
                        if hCoverItem.has_key?('units')
                            s = hCoverItem['units']
                            if s != ''
                                hCovItem[:units] = s
                            end
                        end

                        # coverage item - scale factor
                        if hCoverItem.has_key?('scaleFactor')
                            s = hCoverItem['scaleFactor']
                            if s != ''
                                hCovItem[:scaleFactor] = s
                            end
                        end

                        # coverage item - offset
                        if hCoverItem.has_key?('offset')
                            s = hCoverItem['offset']
                            if s != ''
                                hCovItem[:offset] = s
                            end
                        end

                        # coverage item - mean value
                        if hCoverItem.has_key?('meanValue')
                            s = hCoverItem['meanValue']
                            if s != ''
                                hCovItem[:meanValue] = s
                            end
                        end

                        # coverage item - standard deviation
                        if hCoverItem.has_key?('standardDeviation')
                            s = hCoverItem['standardDeviation']
                            if s != ''
                                hCovItem[:standardDeviation] = s
                            end
                        end

                        # coverage item - bits per value
                        if hCoverItem.has_key?('bitsPerValue')
                            s = hCoverItem['bitsPerValue']
                            if s != ''
                                hCovItem[:bitsPerValue] = s
                            end
                        end

                        # coverage item - classified data
                        if hCoverItem.has_key?('classifiedData')
                            hClassData = hCoverItem['classifiedData']
                            if !hClassData.empty?
                                hCovItem[:classedData] = ClassedData.unpack(hClassData, responseObj)
                            end
                        end

                        # coverage item - sensor info
                        if hCoverItem.has_key?('sensorInfo')
                            hSensorInfo = hCoverItem['sensorInfo']
                            if !hSensorInfo.empty?
                                hCovItem[:sensorInfo] = SensorInfo.unpack(hSensorInfo, responseObj)
                            end
                        end

                        return hCovItem

                    end

                end

            end
        end
    end
end
