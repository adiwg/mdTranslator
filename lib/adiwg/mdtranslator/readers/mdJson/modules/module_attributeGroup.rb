# unpack attribute group
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-18 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_identifier')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_measure')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AttributeGroup

                    def self.unpack(hAttGroup, responseObj)

                        # return nil object if input is empty
                        if hAttGroup.empty?
                            responseObj[:readerExecutionMessages] << 'Attribute Group object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAttGroup = intMetadataClass.newAttributeGroup

                        # attribute group - attribute content type [] (required)
                        if hAttGroup.has_key?('attributeContentType')
                            hAttGroup['attributeContentType'].each do |item|
                                if item != ''
                                    intAttGroup[:attributeContentType] << item
                                end
                            end
                        end
                        if intAttGroup[:attributeContentType].empty?
                            responseObj[:readerExecutionMessages] << 'Attribute Group attribute attributeContentType is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # attribute group - attribute description
                        if hAttGroup.has_key?('attributeDescription')
                            if hAttGroup['attributeDescription'] != ''
                                intAttGroup[:attributeDescription] = hAttGroup['attributeDescription']
                            end
                        end

                        # attribute group - sequence identifier
                        if hAttGroup.has_key?('sequenceIdentifier')
                            if hAttGroup['sequenceIdentifier'] != ''
                                intAttGroup[:sequenceIdentifier] = hAttGroup['sequenceIdentifier']
                            end
                        end

                        # attribute group - sequence identifier type (required if)
                        unless intAttGroup[:sequenceIdentifier].nil?
                            if hAttGroup.has_key?('sequenceIdentifierType')
                                if hAttGroup['sequenceIdentifierType'] != ''
                                    intAttGroup[:sequenceIdentifierType] = hAttGroup['sequenceIdentifierType']
                                end
                            end
                            if intAttGroup[:sequenceIdentifierType].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute Group attribute sequenceIdentifierType is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - attribute identifier [identifier]
                        if hAttGroup.has_key?('attributeIdentifier')
                            aIds = hAttGroup['attributeIdentifier']
                            aIds.each do |item|
                                hIdentifier = Identifier.unpack(item, responseObj)
                                unless hIdentifier.nil?
                                    intAttGroup[:attributeIdentifier] << hIdentifier
                                end
                            end
                        end

                        # attribute group - min value
                        if hAttGroup.has_key?('minValue')
                            if hAttGroup['minValue'] != ''
                                intAttGroup[:minValue] = hAttGroup['minValue']
                            end
                        end

                        # attribute group - max value
                        if hAttGroup.has_key?('maxValue')
                            if hAttGroup['maxValue'] != ''
                                intAttGroup[:maxValue] = hAttGroup['maxValue']
                            end
                        end

                        # attribute group - units (required if)
                        unless intAttGroup[:minValue].nil? && intAttGroup[:maxValue].nil?
                            if hAttGroup.has_key?('units')
                                if hAttGroup['units'] != ''
                                    intAttGroup[:units] = hAttGroup['units']
                                end
                            end
                            if intAttGroup[:units].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute Group attribute units is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - scale factor
                        if hAttGroup.has_key?('scaleFactor')
                            if hAttGroup['scaleFactor'] != ''
                                intAttGroup[:scaleFactor] = hAttGroup['scaleFactor']
                            end
                        end

                        # attribute group - offset
                        if hAttGroup.has_key?('offset')
                            if hAttGroup['offset'] != ''
                                intAttGroup[:offset] = hAttGroup['offset']
                            end
                        end

                        # attribute group - mean value
                        if hAttGroup.has_key?('meanValue')
                            if hAttGroup['meanValue'] != ''
                                intAttGroup[:meanValue] = hAttGroup['meanValue']
                            end
                        end

                        # attribute group - number of values
                        if hAttGroup.has_key?('numberOfValues')
                            if hAttGroup['numberOfValues'] != ''
                                intAttGroup[:numberOfValues] = hAttGroup['numberOfValues']
                            end
                        end

                        # attribute group - standard deviation
                        if hAttGroup.has_key?('standardDeviation')
                            if hAttGroup['standardDeviation'] != ''
                                intAttGroup[:standardDeviation] = hAttGroup['standardDeviation']
                            end
                        end

                        # attribute group - bits per value
                        if hAttGroup.has_key?('bitsPerValue')
                            if hAttGroup['bitsPerValue'] != ''
                                intAttGroup[:bitsPerValue] = hAttGroup['bitsPerValue']
                            end
                        end

                        # attribute group - bound min
                        if hAttGroup.has_key?('boundMin')
                            if hAttGroup['boundMin'] != ''
                                intAttGroup[:boundMin] = hAttGroup['boundMin']
                            end
                        end

                        # attribute group - bound max
                        if hAttGroup.has_key?('boundMax')
                            if hAttGroup['boundMax'] != ''
                                intAttGroup[:boundMax] = hAttGroup['boundMax']
                            end
                        end

                        # attribute group - bound units (required if)
                        unless intAttGroup[:boundMin].nil? && intAttGroup[:boundMax].nil?
                            if hAttGroup.has_key?('boundUnits')
                                if hAttGroup['boundUnits'] != ''
                                    intAttGroup[:boundUnits] = hAttGroup['boundUnits']
                                end
                            end
                            if intAttGroup[:boundUnits].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute Group attribute boundUnits is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - peak response
                        if hAttGroup.has_key?('peakResponse')
                            if hAttGroup['peakResponse'] != ''
                                intAttGroup[:peakResponse] = hAttGroup['peakResponse']
                            end
                        end

                        # attribute group - tone gradations
                        if hAttGroup.has_key?('toneGradations')
                            if hAttGroup['toneGradations'] != ''
                                intAttGroup[:toneGradations] = hAttGroup['toneGradations']
                            end
                        end

                        # attribute group - band boundary definition
                        if hAttGroup.has_key?('bandBoundaryDefinition')
                            if hAttGroup['bandBoundaryDefinition'] != ''
                                intAttGroup[:bandBoundaryDefinition] = hAttGroup['bandBoundaryDefinition']
                            end
                        end

                        # attribute group - nominal spatial resolution {measure}
                        if hAttGroup.has_key?('nominalSpatialResolution')
                            hMeasure = hAttGroup['nominalSpatialResolution']
                            unless hMeasure.empty?
                                hObject = Measure.unpack(hMeasure, responseObj)
                                unless hObject.nil?
                                    intAttGroup[:nominalSpatialResolution] = hObject
                                end
                            end
                        end

                        # attribute group - transfer function type
                        if hAttGroup.has_key?('transferFunctionType')
                            if hAttGroup['transferFunctionType'] != ''
                                intAttGroup[:transferFunctionType] = hAttGroup['transferFunctionType']
                            end
                        end

                        # attribute group - transmitted polarization
                        if hAttGroup.has_key?('transmittedPolarization')
                            if hAttGroup['transmittedPolarization'] != ''
                                intAttGroup[:transmittedPolarization] = hAttGroup['transmittedPolarization']
                            end
                        end

                        # attribute group - detected polarization
                        if hAttGroup.has_key?('detectedPolarization')
                            if hAttGroup['detectedPolarization'] != ''
                                intAttGroup[:detectedPolarization] = hAttGroup['detectedPolarization']
                            end
                        end

                        return intAttGroup

                    end

                end

            end
        end
    end
end
