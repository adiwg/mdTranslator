# unpack an data entity index
# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-07-24 added error reporting of missing items
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module EntityIndex

                    def self.unpack(hIndex, responseObj)

                        # return nil object if input is empty
                        if hIndex.empty?
                            responseObj[:readerExecutionMessages] << 'Entity Index object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intIndex = intMetadataClass.newEntityIndex

                        # entity index - code name (required)
                        # return nil if no entity index is provided
                        if hIndex.has_key?('codeName')
                            intIndex[:indexCode] = hIndex['codeName']
                        end
                        if intIndex[:indexCode].nil? || intIndex[:indexCode] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary entity index name is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end


                        # entity index - allow duplicates (required)
                        # return nil if no unique/duplicate flag is provided
                        if hIndex.has_key?('allowDuplicates')
                            intIndex[:duplicate] = hIndex['allowDuplicates']
                        end
                        if !(intIndex[:duplicate] == true || intIndex[:duplicate] == false)
                            responseObj[:readerExecutionMessages] << 'Data Dictionary entity index unique/duplicate flag is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # entity index - attribute list [] (required)
                        # return nil if no attribute list is provided
                        if hIndex.has_key?('attributeCodeName')
                            intIndex[:attributeNames] = hIndex['attributeCodeName']
                        else
                            intIndex[:attributeNames] = []
                        end
                        if intIndex[:attributeNames].empty?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary entity index attribute list is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intIndex

                    end

                end

            end
        end
    end
end
