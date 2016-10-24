# unpack vertical extent
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-24 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_spatialReference')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module VerticalExtent

                    def self.unpack(hVertical, responseObj)

                        # return nil object if input is empty
                        if hVertical.empty?
                            responseObj[:readerExecutionMessages] << 'Vertical Extent object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intVertical = intMetadataClass.newVerticalExtent

                        # vertical extent - description
                        if hVertical.has_key?('description')
                            if hVertical['description'] != ''
                                intVertical[:description] = hVertical['description']
                            end
                        end

                        # vertical extent - min value (required)
                        if hVertical.has_key?('minValue')
                            intVertical[:minValue] = hVertical['minValue']
                        end
                        if intVertical[:minValue].nil? || intVertical[:minValue] == ''
                            responseObj[:readerExecutionMessages] << 'Vertical Extent is missing minValue'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # vertical extent - max value (required)
                        if hVertical.has_key?('maxValue')
                            intVertical[:maxValue] = hVertical['maxValue']
                        end
                        if intVertical[:maxValue].nil? || intVertical[:maxValue] == ''
                            responseObj[:readerExecutionMessages] << 'Vertical Extent is missing maxValue'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # vertical extent - crs ID {spatialReference} (required)
                        if hVertical.has_key?('crsId')
                            hObject = hVertical['crsId']
                            unless hObject.empty?
                                hReturn = SpatialReferenceSystem.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intVertical[:crsId] = hReturn
                                end
                            end
                        end
                        if intVertical[:crsId].empty?
                            responseObj[:readerExecutionMessages] << 'Vertical Extent is missing crsId'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intVertical

                    end

                end

            end
        end
    end
end
