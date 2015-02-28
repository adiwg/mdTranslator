# unpack spatial reference system
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-09-03 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SpatialReferenceSystem

                    def self.unpack(hSpatialRef)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intSpatialRef = intMetadataClass.newSpatialReferenceSystem

                        # spatial reference system - by name
                        if hSpatialRef.has_key?('name')
                            aSystemNames = hSpatialRef['name']
                            unless aSystemNames.empty?
                                aSystemNames.each do |sRName|
                                    intSpatialRef[:sRNames] << sRName
                                end
                            end
                        end

                        # spatial reference system - by epsg
                        if hSpatialRef.has_key?('epsgNumber')
                            aSystemNames = hSpatialRef['epsgNumber']
                            unless aSystemNames.empty?
                                aSystemNames.each do |sREPSG|
                                    intSpatialRef[:sREPSGs] << sREPSG
                                end
                            end
                        end

                        # spatial reference system - by wkt
                        if hSpatialRef.has_key?('wkt')
                            aSystemNames = hSpatialRef['wkt']
                            unless aSystemNames.empty?
                                aSystemNames.each do |sRWKT|
                                    intSpatialRef[:sRWKTs] << sRWKT
                                end
                            end
                        end

                        return intSpatialRef
                    end

                end

            end
        end
    end
end
