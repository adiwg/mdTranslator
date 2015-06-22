# unpack an data entity index
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module EntityIndex

                    def self.unpack(hIndex, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intIndex = intMetadataClass.newEntityIndex

                        # entity index - code name
                        if hIndex.has_key?('codeName')
                            s = hIndex['codeName']
                            if s != ''
                                intIndex[:indexCode] = s
                            end
                        end

                        # entity index - allow duplicates
                        if hIndex.has_key?('allowDuplicates')
                            s = hIndex['allowDuplicates']
                            if s != ''
                                intIndex[:duplicate] = s
                            end
                        end

                        # entity index - attribute list
                        if hIndex.has_key?('attributeCodeName')
                            aKeyAttributes = hIndex['attributeCodeName']
                            unless aKeyAttributes.empty?
                                intIndex[:attributeNames] = aKeyAttributes
                            end
                        end

                        return intIndex
                    end

                end

            end
        end
    end
end
