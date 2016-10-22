# unpack spatial representation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_gridRepresentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_vectorRepresentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_georectifiedRepresentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_georeferencableRepresentation')


module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SpatialRepresentation

                    def self.unpack(hRepresent, responseObj)

                        # return nil object if input is empty
                        if hRepresent.empty?
                            responseObj[:readerExecutionMessages] << 'Spatial Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intRepresent = intMetadataClass.newSpatialRepresentation

                        # spatial representation - type (required)
                        if hRepresent.has_key?('type')
                            if hRepresent['type'] != ''
                                type = hRepresent['type']
                                if %w{ grid vector georectified georeferencable }.one? { |word| word == type }
                                    intRepresent[:type] = hRepresent['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Spatial Representation type must be grid, vector, georectified, or georeferencable'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intRepresent[:type].nil? || intRepresent[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Spatial Resolution attribute type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # spatial representation - grid representation (required if)
                        if hRepresent['type'] == 'grid'
                            if hRepresent.has_key?('gridRepresentation')
                                hRep = hRepresent['gridRepresentation']
                                unless hRep.empty?
                                    hObject = GridRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:gridRepresentation] = hObject
                                    end
                                end
                            end
                            if intRepresent[:gridRepresentation].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Representation is missing gridRepresentation object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial representation - vector representation (required if)
                        if hRepresent['type'] == 'vector'
                            if hRepresent.has_key?('vectorRepresentation')
                                hRep = hRepresent['vectorRepresentation']
                                unless hRep.empty?
                                    hObject = VectorRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:vectorRepresentation] = hObject
                                    end
                                end
                            end
                            if intRepresent[:vectorRepresentation].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Representation is missing vectorRepresentation object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial representation - georectified representation (required if)
                        if hRepresent['type'] == 'georectified'
                            if hRepresent.has_key?('georectifiedRepresentation')
                                hRep = hRepresent['georectifiedRepresentation']
                                unless hRep.empty?
                                    hObject = GeorectifiedRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:georectifiedRepresentation] = hObject
                                    end
                                end
                            end
                            if intRepresent[:georectifiedRepresentation].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Representation is missing georectifiedRepresentation object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial representation - georeferencable representation (required if)
                        if hRepresent['type'] == 'georeferencable'
                            if hRepresent.has_key?('georeferencableRepresentation')
                                hRep = hRepresent['georeferencableRepresentation']
                                unless hRep.empty?
                                    hObject = GeoreferencableRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:georeferencableRepresentation] = hObject
                                    end
                                end
                            end
                            if intRepresent[:georeferencableRepresentation].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Representation is missing georectifiedRepresentation object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intRepresent

                    end

                end

            end
        end
    end
end