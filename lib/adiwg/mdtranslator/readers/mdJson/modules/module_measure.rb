# unpack measure
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-17 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Measure

                    def self.unpack(hMeasure, responseObj)

                        # return nil object if input is empty
                        if hMeasure.empty?
                            responseObj[:readerExecutionMessages] << 'Measure object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMeasure = intMetadataClass.newMeasure

                        # measure - type enumeration (required)
                        if hMeasure.has_key?('type')
                            if hMeasure['type'] != ''
                                type = hMeasure['type']
                                if %w{ distance length vertical angle }.one? { |word| word == type }
                                    intMeasure[:type] = hMeasure['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Measure type must be distance, length, vertical, or angle'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intMeasure[:type].nil? || intMeasure[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Measure attribute type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # measure - value (required)
                        if hMeasure.has_key?('value')
                            intMeasure[:value] = hMeasure['value']
                        end
                        if intMeasure[:value].nil? || intMeasure[:value] == ''
                            responseObj[:readerExecutionMessages] << 'Measure attribute value is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # measure - unit of measure (required)
                        if hMeasure.has_key?('unitOfMeasure')
                            intMeasure[:unitOfMeasure] = hMeasure['unitOfMeasure']
                        end
                        if intMeasure[:unitOfMeasure].nil? || intMeasure[:unitOfMeasure] == ''
                            responseObj[:readerExecutionMessages] << 'Measure attribute unitOfMeasure is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intMeasure

                    end

                end

            end
        end
    end
end
