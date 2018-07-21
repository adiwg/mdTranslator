# unpack attribute group
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-15 refactored error and warning messaging
# 	Stan Smith 2016-10-18 original script

require_relative 'module_attribute'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module AttributeGroup

               def self.unpack(hAttGroup, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  inContext = 'coverage description'

                  # return nil object if input is empty
                  if hAttGroup.empty?
                     @MessagePath.issueWarning(50, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAttGroup = intMetadataClass.newAttributeGroup

                  outContext = inContext + ' attribute group'

                  # attribute group - attribute content type [] (required)
                  if hAttGroup.has_key?('attributeContentType')
                     hAttGroup['attributeContentType'].each do |item|
                        unless item == ''
                           intAttGroup[:attributeContentTypes] << item
                        end
                     end
                  end
                  if intAttGroup[:attributeContentTypes].empty?
                     @MessagePath.issueError(51, responseObj, inContext)
                  end

                  # attribute group - attribute []
                  if hAttGroup.has_key?('attribute')
                     aItems = hAttGroup['attribute']
                     aItems.each do |item|
                        hReturn = Attribute.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:attributes] << hReturn
                        end
                     end
                  end

                  return intAttGroup

               end

            end

         end
      end
   end
end
