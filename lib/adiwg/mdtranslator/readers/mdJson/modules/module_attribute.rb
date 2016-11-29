# unpack attribute group
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-18 original script

require_relative 'module_identifier'
require_relative 'module_measure'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Attribute

                    def self.unpack(hAttribute, responseObj)

                        # return nil object if input is empty
                        if hAttribute.empty?
                            responseObj[:readerExecutionMessages] << 'Attribute object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAttGroup = intMetadataClass.newAttribute

                        # attribute group - sequence identifier
                        if hAttribute.has_key?('sequenceIdentifier')
                            if hAttribute['sequenceIdentifier'] != ''
                                intAttGroup[:sequenceIdentifier] = hAttribute['sequenceIdentifier']
                            end
                        end

                        # attribute group - sequence identifier type (required if)
                        unless intAttGroup[:sequenceIdentifier].nil?
                            if hAttribute.has_key?('sequenceIdentifierType')
                                if hAttribute['sequenceIdentifierType'] != ''
                                    intAttGroup[:sequenceIdentifierType] = hAttribute['sequenceIdentifierType']
                                end
                            end
                            if intAttGroup[:sequenceIdentifierType].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute attribute sequenceIdentifierType is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - attribute description
                        if hAttribute.has_key?('attributeDescription')
                            if hAttribute['attributeDescription'] != ''
                                intAttGroup[:attributeDescription] = hAttribute['attributeDescription']
                            end
                        end

                        # attribute group - attribute identifier [identifier]
                        if hAttribute.has_key?('attributeIdentifier')
                            aItems = hAttribute['attributeIdentifier']
                            aItems.each do |item|
                                hReturn = Identifier.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intAttGroup[:attributeIdentifiers] << hReturn
                                end
                            end
                        end

                        # attribute group - min value
                        if hAttribute.has_key?('minValue')
                            if hAttribute['minValue'] != ''
                                intAttGroup[:minValue] = hAttribute['minValue']
                            end
                        end

                        # attribute group - max value
                        if hAttribute.has_key?('maxValue')
                            if hAttribute['maxValue'] != ''
                                intAttGroup[:maxValue] = hAttribute['maxValue']
                            end
                        end

                        # attribute group - units (required if)
                        unless intAttGroup[:minValue].nil? && intAttGroup[:maxValue].nil?
                            if hAttribute.has_key?('units')
                                if hAttribute['units'] != ''
                                    intAttGroup[:units] = hAttribute['units']
                                end
                            end
                            if intAttGroup[:units].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute attribute units is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - scale factor
                        if hAttribute.has_key?('scaleFactor')
                            if hAttribute['scaleFactor'] != ''
                                intAttGroup[:scaleFactor] = hAttribute['scaleFactor']
                            end
                        end

                        # attribute group - offset
                        if hAttribute.has_key?('offset')
                            if hAttribute['offset'] != ''
                                intAttGroup[:offset] = hAttribute['offset']
                            end
                        end

                        # attribute group - mean value
                        if hAttribute.has_key?('meanValue')
                            if hAttribute['meanValue'] != ''
                                intAttGroup[:meanValue] = hAttribute['meanValue']
                            end
                        end

                        # attribute group - number of values
                        if hAttribute.has_key?('numberOfValues')
                            if hAttribute['numberOfValues'] != ''
                                intAttGroup[:numberOfValues] = hAttribute['numberOfValues']
                            end
                        end

                        # attribute group - standard deviation
                        if hAttribute.has_key?('standardDeviation')
                            if hAttribute['standardDeviation'] != ''
                                intAttGroup[:standardDeviation] = hAttribute['standardDeviation']
                            end
                        end

                        # attribute group - bits per value
                        if hAttribute.has_key?('bitsPerValue')
                            if hAttribute['bitsPerValue'] != ''
                                intAttGroup[:bitsPerValue] = hAttribute['bitsPerValue']
                            end
                        end

                        # attribute group - bound min
                        if hAttribute.has_key?('boundMin')
                            if hAttribute['boundMin'] != ''
                                intAttGroup[:boundMin] = hAttribute['boundMin']
                            end
                        end

                        # attribute group - bound max
                        if hAttribute.has_key?('boundMax')
                            if hAttribute['boundMax'] != ''
                                intAttGroup[:boundMax] = hAttribute['boundMax']
                            end
                        end

                        # attribute group - bound units (required if)
                        unless intAttGroup[:boundMin].nil? && intAttGroup[:boundMax].nil?
                            if hAttribute.has_key?('boundUnits')
                                if hAttribute['boundUnits'] != ''
                                    intAttGroup[:boundUnits] = hAttribute['boundUnits']
                                end
                            end
                            if intAttGroup[:boundUnits].nil?
                                responseObj[:readerExecutionMessages] << 'Attribute attribute boundUnits is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # attribute group - peak response
                        if hAttribute.has_key?('peakResponse')
                            if hAttribute['peakResponse'] != ''
                                intAttGroup[:peakResponse] = hAttribute['peakResponse']
                            end
                        end

                        # attribute group - tone gradations
                        if hAttribute.has_key?('toneGradations')
                            if hAttribute['toneGradations'] != ''
                                intAttGroup[:toneGradations] = hAttribute['toneGradations']
                            end
                        end

                        # attribute group - band boundary definition
                        if hAttribute.has_key?('bandBoundaryDefinition')
                            if hAttribute['bandBoundaryDefinition'] != ''
                                intAttGroup[:bandBoundaryDefinition] = hAttribute['bandBoundaryDefinition']
                            end
                        end

                        # attribute group - nominal spatial resolution {measure}
                        if hAttribute.has_key?('nominalSpatialResolution')
                            hMeasure = hAttribute['nominalSpatialResolution']
                            unless hMeasure.empty?
                                hObject = Measure.unpack(hMeasure, responseObj)
                                unless hObject.nil?
                                    intAttGroup[:nominalSpatialResolution] = hObject
                                end
                            end
                        end

                        # attribute group - transfer function type
                        if hAttribute.has_key?('transferFunctionType')
                            if hAttribute['transferFunctionType'] != ''
                                intAttGroup[:transferFunctionType] = hAttribute['transferFunctionType']
                            end
                        end

                        # attribute group - transmitted polarization
                        if hAttribute.has_key?('transmittedPolarization')
                            if hAttribute['transmittedPolarization'] != ''
                                intAttGroup[:transmittedPolarization] = hAttribute['transmittedPolarization']
                            end
                        end

                        # attribute group - detected polarization
                        if hAttribute.has_key?('detectedPolarization')
                            if hAttribute['detectedPolarization'] != ''
                                intAttGroup[:detectedPolarization] = hAttribute['detectedPolarization']
                            end
                        end

                        return intAttGroup

                    end

                end

            end
        end
    end
end
