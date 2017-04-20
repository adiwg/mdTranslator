# unpack spatial reference system
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-16 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-09-03 original script

require_relative 'module_identifier'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SpatialReferenceSystem

                    def self.unpack(hSpatialRef, responseObj)

                        # return nil object if input is empty
                        if hSpatialRef.empty?
                            responseObj[:readerExecutionMessages] << 'Spatial Reference System object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intSpatialRef = intMetadataClass.newSpatialReferenceSystem

                        # spatial reference system - type
                        if hSpatialRef.has_key?('referenceSystemType')
                            if hSpatialRef['referenceSystemType'] != ''
                                intSpatialRef[:systemType] = hSpatialRef['referenceSystemType']
                            end
                        end

                        # spatial reference system - reference system {identifier}
                        if hSpatialRef.has_key?('referenceSystemIdentifier')
                            hObject = hSpatialRef['referenceSystemIdentifier']
                            unless hObject.empty?
                                hReturn = Identifier.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intSpatialRef[:systemIdentifier] = hReturn
                                end
                            end
                        end

                        if intSpatialRef[:systemType].nil? && intSpatialRef[:systemIdentifier].empty?
                            responseObj[:readerExecutionMessages] << 'Spatial Reference System must declare reference system type or reference system identifier'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intSpatialRef
                    end

                end

            end
        end
    end
end
