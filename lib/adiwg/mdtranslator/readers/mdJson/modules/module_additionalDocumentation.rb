# unpack additional documentation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-13 refactored error and warning messaging
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-30 added return if empty input
#  ... found & fixed error of method using associatedResource object instead of
#  ... additionalDocumentation object
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-11-06 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module AdditionalDocumentation

               def self.unpack(hAddDoc, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hAddDoc.empty?
                     @MessagePath.issueWarning(1, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAddDoc = intMetadataClass.newAdditionalDocumentation

                  # additional documentation - resource type [] (required) {resourceType}
                  if hAddDoc.has_key?('resourceType')
                     hAddDoc['resourceType'].each do |item|
                        unless item.empty?
                           hReturn = ResourceType.unpack(item, responseObj)
                           unless hReturn.nil?
                              intAddDoc[:resourceTypes] << hReturn
                           end
                        end
                     end
                  end
                  if intAddDoc[:resourceTypes].empty?
                     @MessagePath.issueError(2, responseObj)
                  end

                  # additional documentation - citation [] (required)
                  if hAddDoc.has_key?('citation')
                     hAddDoc['citation'].each do |item|
                        hDoc = Citation.unpack(item, responseObj)
                        unless hDoc.nil?
                           intAddDoc[:citation] << hDoc
                        end
                     end
                  end
                  if intAddDoc[:citation].empty?
                     @MessagePath.issueError(3, responseObj)
                  end

                  return intAddDoc

               end

            end

         end
      end
   end
end
