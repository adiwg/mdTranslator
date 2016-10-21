# unpack georectified representation
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_gridRepresentation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeorectifiedRepresentation

                    def self.unpack(hGeoRec, responseObj)

                        # return nil object if input is empty
                        if hGeoRec.empty?
                            responseObj[:readerExecutionMessages] << 'Georectified Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoRec = intMetadataClass.newGeorectifiedInfo

                        # georectified representation - grid representation (required)
                        if hGeoRec.has_key?('gridRepresentation')
                            hObject = hGeoRec['gridRepresentation']
                            unless hObject.empty?
                                hReturn = GridRepresentation.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intGeoRec[:gridRepresentation] = hReturn
                                end
                            end
                        end
                        if intGeoRec[:gridRepresentation].empty?
                            responseObj[:readerExecutionMessages] << 'Georectified Representation is missing GridRepresentation object'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georectified representation - check point availability (required)
                        if hGeoRec.has_key?('checkPointAvailable')
                            if hGeoRec['checkPointAvailable'] != ''
                                intGeoRec[:checkPointAvailable] = hGeoRec['checkPointAvailable']
                            end
                        end

                        # georectified representation - check point description
                        if hGeoRec.has_key?('checkPointDescription')
                            if hGeoRec['checkPointDescription'] != ''
                                intGeoRec[:checkPointDescription] = hGeoRec['checkPointDescription']
                            end
                        end

                        # georectified representation - corner points [2 or 4] (required)
                        if hGeoRec.has_key?('cornerPoints')
                            unless hGeoRec['cornerPoints'].empty?
                                intGeoRec[:cornerPoints] = hGeoRec['cornerPoints']
                            end
                        end
                        unless intGeoRec[:cornerPoints].length == 2 || intGeoRec[:cornerPoints].length == 4
                            responseObj[:readerExecutionMessages] << 'Georectified Representation has invalid cornerPoints array'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georectified representation - center point
                        if hGeoRec.has_key?('centerPoint')
                            unless hGeoRec['centerPoint'].empty?
                                intGeoRec[:centerPoint] = hGeoRec['centerPoint']
                            end
                        end

                        # georectified representation - point in pixel (required)
                        if hGeoRec.has_key?('pointInPixel')
                            if hGeoRec['pointInPixel'] != ''
                                intGeoRec[:pointInPixel] = hGeoRec['pointInPixel']
                            end
                        end
                        if intGeoRec[:pointInPixel].nil?
                            responseObj[:readerExecutionMessages] << 'Georectified Representation is missing pointInPixel attribute'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georectified representation - transformation dimension description
                        if hGeoRec.has_key?('transformationDimensionDescription')
                            if hGeoRec['transformationDimensionDescription'] != ''
                                intGeoRec[:transformationDimensionDescription] = hGeoRec['transformationDimensionDescription']
                            end
                        end

                        # georectified representation - transformation dimension mapping
                        if hGeoRec.has_key?('transformationDimensionMapping')
                            if hGeoRec['transformationDimensionMapping'] != ''
                                intGeoRec[:transformationDimensionMapping] = hGeoRec['transformationDimensionMapping']
                            end
                        end

                        return intGeoRec

                    end

                end

            end
        end
    end
end
