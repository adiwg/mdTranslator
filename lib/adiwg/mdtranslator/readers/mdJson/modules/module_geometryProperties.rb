# unpack geometry properties
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-25 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeometryProperties

                    def self.unpack(hGeoProp, responseObj)

                        # return nil object if input is empty
                        if hGeoProp.empty?
                            responseObj[:readerExecutionMessages] << 'Geometry Properties object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoProp = intMetadataClass.newGeometryProperties

                        # geometry properties - feature name []
                        if hGeoProp.has_key?('featureName')
                            hGeoProp['featureName'].each do |item|
                                if item != ''
                                    intGeoProp[:featureNames] << item
                                end
                            end
                        end

                        # geometry properties - description
                        if hGeoProp.has_key?('description')
                            if hGeoProp['description'] != ''
                                intGeoProp[:description] = hGeoProp['description']
                            end
                        end

                        # geometry properties - includes data {Boolean}
                        if hGeoProp.has_key?('includesData')
                            if hGeoProp['includesData'] === true
                                intGeoProp[:includesData] = hGeoProp['includesData']
                            end
                        end

                        # geometry properties - identifier []
                        if hGeoProp.has_key?('identifier')
                            hGeoProp['identifier'].each do |item|
                                if item != ''
                                    intGeoProp[:identifiers] << item
                                end
                            end
                        end

                        # geometry properties - feature scope
                        if hGeoProp.has_key?('featureScope')
                            if hGeoProp['featureScope'] != ''
                                intGeoProp[:featureScope] = hGeoProp['featureScope']
                            end
                        end

                        # geometry properties - feature acquisition method
                        if hGeoProp.has_key?('featureAcquisitionMethod')
                            if hGeoProp['featureAcquisitionMethod'] != ''
                                intGeoProp[:featureAcquisitionMethod] = hGeoProp['featureAcquisitionMethod']
                            end
                        end

                        return intGeoProp

                    end

                end

            end
        end
    end
end
