# unpack distance measure
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-16 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DistanceMeasure

                    def self.unpack(hDistance, responseObj)

                        # return nil object if input is empty
                        if hDistance.empty?
                            responseObj[:readerExecutionMessages] << 'Distance Measure object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDistance = intMetadataClass.newDistanceMeasure

                        # distance measure - distance (required)
                        if hDistance.has_key?('distance')
                            intDistance[:distance] = hDistance['distance']
                        end
                        if intDistance[:distance].nil? || intDistance[:distance] == ''
                            responseObj[:readerExecutionMessages] << 'Distance Measure attribute distance is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # distance measure - unit of measure {required}
                        if hDistance.has_key?('unitOfMeasure')
                            intDistance[:unitOfMeasure] = hDistance['unitOfMeasure']
                        end
                        if intDistance[:unitOfMeasure].nil? || intDistance[:unitOfMeasure] == ''
                            responseObj[:readerExecutionMessages] << 'Distance Measure attribute unitOfMeasure is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intDistance
                    end

                end

            end
        end
    end
end
