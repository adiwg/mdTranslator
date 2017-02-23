# unpack spatial representation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'
require_relative 'module_vectorRepresentation'
require_relative 'module_georectifiedRepresentation'
require_relative 'module_georeferenceableRepresentation'

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
                        haveOne = false

                        # spatial representation - grid representation (required if not others)
                        if hRepresent['type'] == 'grid'
                            if hRepresent.has_key?('gridRepresentation')
                                hRep = hRepresent['gridRepresentation']
                                unless hRep.empty?
                                    hObject = GridRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:gridRepresentation] = hObject
                                        haveOne = true
                                    end
                                end
                            end
                        end

                        # spatial representation - vector representation (required if not others)
                        if hRepresent['type'] == 'vector'
                            if hRepresent.has_key?('vectorRepresentation')
                                hRep = hRepresent['vectorRepresentation']
                                unless hRep.empty?
                                    hObject = VectorRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:vectorRepresentation] = hObject
                                        haveOne = true
                                    end
                                end
                            end
                        end

                        # spatial representation - georectified representation (required if not others)
                        if hRepresent['type'] == 'georectified'
                            if hRepresent.has_key?('georectifiedRepresentation')
                                hRep = hRepresent['georectifiedRepresentation']
                                unless hRep.empty?
                                    hObject = GeorectifiedRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:georectifiedRepresentation] = hObject
                                        haveOne = true
                                    end
                                end
                            end
                        end

                        # spatial representation - georeferenceable representation (required if not others)
                        if hRepresent['type'] == 'georeferenceable'
                            if hRepresent.has_key?('georeferenceableRepresentation')
                                hRep = hRepresent['georeferenceableRepresentation']
                                unless hRep.empty?
                                    hObject = GeoreferenceableRepresentation.unpack(hRep, responseObj)
                                    unless hObject.nil?
                                        intRepresent[:georeferenceableRepresentation] = hObject
                                        haveOne = true
                                    end
                                end
                            end
                        end

                        unless haveOne
                            responseObj[:readerExecutionMessages] << 'Spatial Representation did not have an object of supported type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intRepresent

                    end

                end

            end
        end
    end
end
