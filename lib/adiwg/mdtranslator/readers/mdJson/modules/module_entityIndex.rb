# unpack an data entity index
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 added error reporting of missing items
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module EntityIndex

               def self.unpack(hIndex, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hIndex.empty?
                     @MessagePath.issueWarning(260, responseObj, inContext)
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
                     @MessagePath.issueError(261, responseObj, inContext)
                  end

                  # entity index - allow duplicates (required)
                  if hIndex.has_key?('allowDuplicates')
                     if hIndex['allowDuplicates'] === true
                        intIndex[:duplicate] = true
                     end
                  end

                  # entity index - attribute list [] (required)
                  # return nil if no attribute list is provided
                  if hIndex.has_key?('attributeCodeName')
                     intIndex[:attributeNames] = hIndex['attributeCodeName']
                  end
                  if intIndex[:attributeNames].empty?
                     @MessagePath.issueError(262, responseObj, inContext)
                  end

                  return intIndex

               end

            end

         end
      end
   end
end
