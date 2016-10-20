# unpack vector object
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module VectorObject

                    def self.unpack(hVecObj, responseObj)

                        # return nil object if input is empty
                        if hVecObj.empty?
                            responseObj[:readerExecutionMessages] << 'Vector Object object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intVecObj = intMetadataClass.newVectorObject

                        # vector object - object type (required)
                        if hVecObj.has_key?('objectType')
                            if hVecObj['objectType'] != ''
                                intVecObj[:objectType] = hVecObj['objectType']
                            end
                        end
                        if intVecObj[:objectType].nil?
                            responseObj[:readerExecutionMessages] << 'Vector Object attribute objectType is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # vector object - object count
                        if hVecObj.has_key?('objectCount')
                            if hVecObj['objectCount'] != ''
                                intVecObj[:objectCount] = hVecObj['objectCount']
                            end
                        end

                        return intVecObj

                    end

                end

            end
        end
    end
end
