# unpack vector representation
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_vectorObject')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module VectorRepresentation

                    def self.unpack(hVector, responseObj)

                        # return nil object if input is empty
                        if hVector.empty?
                            responseObj[:readerExecutionMessages] << 'Vector Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intVector = intMetadataClass.newVectorInfo

                        # vector representation - topology level
                        if hVector.has_key?('topologyLevel')
                            if hVector['topologyLevel'] != ''
                                intVector[:topologyLevel] = hVector['topologyLevel']
                            end
                        end

                        # vector representation - vector object []
                        if hVector.has_key?('vectorObject')
                            hVector['vectorObject'].each do |item|
                                hVec = VectorObject.unpack(item, responseObj)
                                unless hVec.nil?
                                    intVector[:vectorObject] << hVec
                                end
                            end
                        end

                        return intVector

                    end

                end

            end
        end
    end
end
