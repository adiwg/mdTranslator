# unpack a data dictionary domain item
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2018-01-24 add domain item reference
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-07-23 added error reporting of missing items
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module DomainItem

               def self.unpack(hDomItem, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hDomItem.empty?
                     @MessagePath.issueWarning(210, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intItem = intMetadataClass.newDomainItem

                  # data dictionary domain item - name (required)
                  if hDomItem.has_key?('name')
                     intItem[:itemName] = hDomItem['name']
                  end
                  if intItem[:itemName].nil? || intItem[:itemName] == ''
                     @MessagePath.issueError(211, responseObj, inContext)
                  end

                  # data dictionary domain item - value (required)
                  if hDomItem.has_key?('value')
                     intItem[:itemValue] = hDomItem['value']
                  end
                  if intItem[:itemValue].nil? || intItem[:itemValue] == ''
                     @MessagePath.issueError(212, responseObj, inContext)
                  end

                  # data dictionary domain item - definition (required)
                  if hDomItem.has_key?('definition')
                     intItem[:itemDefinition] = hDomItem['definition']
                  end
                  if intItem[:itemDefinition].nil? || intItem[:itemDefinition] == ''
                     @MessagePath.issueError(213, responseObj, inContext)
                  end

                  # data dictionary domain item - reference {citation}
                  if hDomItem.has_key?('reference')
                     hCitation = hDomItem['reference']
                     unless hCitation.empty?
                        hReturn = Citation.unpack(hCitation, responseObj, inContext)
                        unless hReturn.nil?
                           intItem[:itemReference] = hReturn
                        end
                     end
                  end

                  return intItem
               end

            end

         end
      end
   end
end
