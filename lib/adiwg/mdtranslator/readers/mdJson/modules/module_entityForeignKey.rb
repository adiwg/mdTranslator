# unpack an data entity foreign key
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2016-10-06 refactored for mdJson 2.0
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-07-24 added error reporting of missing items
# 	Stan Smith 2013-12-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module EntityForeignKey

               def self.unpack(hFKey, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hFKey.empty?
                     @MessagePath.issueWarning(250, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intFKey = intMetadataClass.newEntityForeignKey

                  # entity foreign key - local attribute code name [] (required)
                  # return nil if no local attribute is provided
                  if hFKey.has_key?('localAttributeCodeName')
                     intFKey[:fkLocalAttributes] = hFKey['localAttributeCodeName']
                  end
                  if intFKey[:fkLocalAttributes].empty?
                     @MessagePath.issueError(251, responseObj, inContext)
                  end

                  # entity foreign key - referenced entity code name (required)
                  # return nil if no referenced entity is provided
                  if hFKey.has_key?('referencedEntityCodeName')
                     intFKey[:fkReferencedEntity] = hFKey['referencedEntityCodeName']
                  end
                  if intFKey[:fkReferencedEntity].nil? || intFKey[:fkReferencedEntity] == ''
                     @MessagePath.issueError(252, responseObj, inContext)
                  end

                  # entity foreign key - referenced attribute code name [] (required)
                  # return nil if no referenced attribute is provided
                  if hFKey.has_key?('referencedAttributeCodeName')
                     intFKey[:fkReferencedAttributes] = hFKey['referencedAttributeCodeName']
                  end
                  if intFKey[:fkReferencedAttributes].empty?
                     @MessagePath.issueError(253, responseObj, inContext)
                  end

                  return intFKey

               end

            end

         end
      end
   end
end
