# unpack georeferencable representation
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_gridRepresentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeoreferencableRepresentation

                    def self.unpack(hGeoRef, responseObj)

                        # return nil object if input is empty
                        if hGeoRef.empty?
                            responseObj[:readerExecutionMessages] << 'Georeferencable Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoRef = intMetadataClass.newGeoreferencableInfo

                        # georeferencable representation - grid representation (required)
                        if hGeoRef.has_key?('gridRepresentation')
                            hGrid = hGeoRef['gridRepresentation']
                            if !hGrid.empty?
                                intGeoRef[:gridRepresentation] = GridRepresentation.unpack(hGrid, responseObj)
                            end
                        end
                        if intGeoRef[:gridRepresentation].empty?
                            responseObj[:readerExecutionMessages] << 'Georeferencable Representation is missing GridRepresentation object'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georeferencable representation - control point availability (required)
                        if hGeoRef.has_key?('controlPointAvailability')
                            if hGeoRef['controlPointAvailability'] != ''
                                intGeoRef[:controlPointAvailability] = hGeoRef['controlPointAvailability']
                            end
                        end

                        # georeferencable representation - orientation parameter availability (required)
                        if hGeoRef.has_key?('orientationParameterAvailability')
                            if hGeoRef['orientationParameterAvailability'] != ''
                                intGeoRef[:orientationParameterAvailability] = hGeoRef['orientationParameterAvailability']
                            end
                        end

                        # georeferencable representation - orientation parameter description
                        if hGeoRef.has_key?('orientationParameterDescription')
                            if hGeoRef['orientationParameterDescription'] != ''
                                intGeoRef[:orientationParameterDescription] = hGeoRef['orientationParameterDescription']
                            end
                        end

                        # georeferencable representation - georeferenced parameter (required)
                        if hGeoRef.has_key?('georeferencedParameter')
                            if hGeoRef['georeferencedParameter'] != ''
                                intGeoRef[:georeferencedParameter] = hGeoRef['georeferencedParameter']
                            end
                        end
                        if intGeoRef[:georeferencedParameter].nil?
                            responseObj[:readerExecutionMessages] << 'Georeferencable Representation is missing georeferencedParameter'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # georeferencable representation - parameter citation [citation]
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
