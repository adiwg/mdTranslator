# unpack georeferenceable representation
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'
require_relative 'module_citation'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeoreferenceableRepresentation

                    def self.unpack(hGeoRef, responseObj)

                        # return nil object if input is empty
                        if hGeoRef.empty?
                            responseObj[:readerExecutionMessages] << 'Georeferenceable Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoRef = intMetadataClass.newGeoreferenceableInfo

                        # georeferenceable representation - grid representation (required)
                        if hGeoRef.has_key?('gridRepresentation')
                            hObject = hGeoRef['gridRepresentation']
                            unless hObject.empty?
                                hReturn = GridRepresentation.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intGeoRef[:gridRepresentation] = hReturn
                                end
                            end
                        end
                        if intGeoRef[:gridRepresentation].empty?
                            responseObj[:readerExecutionMessages] << 'Georeferenceable Representation is missing GridRepresentation object'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georeferenceable representation - control point availability (required)
                        if hGeoRef.has_key?('controlPointAvailability')
                            if hGeoRef['controlPointAvailability'] === true
                                intGeoRef[:controlPointAvailability] = hGeoRef['controlPointAvailability']
                            end
                        end

                        # georeferenceable representation - orientation parameter availability (required)
                        if hGeoRef.has_key?('orientationParameterAvailability')
                            if hGeoRef['orientationParameterAvailability'] === true
                                intGeoRef[:orientationParameterAvailability] = hGeoRef['orientationParameterAvailability']
                            end
                        end

                        # georeferenceable representation - orientation parameter description
                        if hGeoRef.has_key?('orientationParameterDescription')
                            if hGeoRef['orientationParameterDescription'] != ''
                                intGeoRef[:orientationParameterDescription] = hGeoRef['orientationParameterDescription']
                            end
                        end

                        # georeferenceable representation - georeferenced parameter (required)
                        if hGeoRef.has_key?('georeferencedParameter')
                            if hGeoRef['georeferencedParameter'] != ''
                                intGeoRef[:georeferencedParameter] = hGeoRef['georeferencedParameter']
                            end
                        end
                        if intGeoRef[:georeferencedParameter].nil?
                            responseObj[:readerExecutionMessages] << 'Georeferenceable Representation is missing georeferencedParameter'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georeferenceable representation - parameter citation [citation]
                        if hGeoRef.has_key?('parameterCitation')
                            aCitation = hGeoRef['parameterCitation']
                            aCitation.each do |item|
                                hCitation = Citation.unpack(item, responseObj)
                                unless hCitation.nil?
                                    intGeoRef[:parameterCitation] << hCitation
                                end
                            end
                        end

                        return intGeoRef

                    end

                end

            end
        end
    end
end
