# unpack content information
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-10-18 original script

require_relative 'module_identifier'
require_relative 'module_attributeGroup'
require_relative 'module_imageDescription'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module CoverageDescription

               def self.unpack(hContent, responseObj)

                  # return nil object if input is empty
                  if hContent.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: coverage description object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intContent = intMetadataClass.newCoverageDescription

                  # content information - coverage name (required)
                  if hContent.has_key?('coverageName')
                     unless hContent['coverageName'] == ''
                        intContent[:coverageName] = hContent['coverageName']
                     end
                  end
                  if intContent[:coverageName].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson coverage description name is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # content information - coverage description (required)
                  if hContent.has_key?('coverageDescription')
                     unless hContent['coverageDescription'] == ''
                        intContent[:coverageDescription] = hContent['coverageDescription']
                     end
                  end
                  if intContent[:coverageDescription].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson coverage description description is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # content information - processing level code
                  if hContent.has_key?('processingLevelCode')
                     hObject = hContent['processingLevelCode']
                     unless hObject.empty?
                        hReturn = Identifier.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intContent[:processingLevelCode] = hReturn
                        end
                     end
                  end

                  # content information - attribute group []
                  if hContent.has_key?('attributeGroup')
                     hContent['attributeGroup'].each do |item|
                        hAttGrp = AttributeGroup.unpack(item, responseObj)
                        unless hAttGrp.nil?
                           intContent[:attributeGroups] << hAttGrp
                        end
                     end
                  end

                  # content information - image description
                  if hContent.has_key?('imageDescription')
                     hObject = hContent['imageDescription']
                     unless hObject.empty?
                        hReturn = ImageDescription.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intContent[:imageDescription] = hReturn
                        end
                     end
                  end

                  return intContent

               end

            end

         end
      end
   end
end
