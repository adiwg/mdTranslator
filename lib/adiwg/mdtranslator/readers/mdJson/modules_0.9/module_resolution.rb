# unpack resolution
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Resolution

                    def self.unpack(hResolution)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResolution = intMetadataClass.newResolution

                        # resolution - equivalent scale
                        if hResolution.has_key?('equivalentScale')
                            s = hResolution['equivalentScale']
                            if s != ''
                                intResolution[:equivalentScale] = s
                            end
                        end

                        # resolution - distance
                        if hResolution.has_key?('distance')
                            s = hResolution['distance']
                            if s != ''
                                intResolution[:distance] = s
                            end
                        end

                        # resolution - uom
                        if hResolution.has_key?('uom')
                            s = hResolution['uom']
                            if s != ''
                                intResolution[:distanceUOM] = s
                            end
                        end

                        return intResolution
                    end

                end

            end
        end
    end
end
