# unpack additional documentation
# Reader - ADIwg JSON to internal dimension

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-10-18 original script

require_relative 'module_measure'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Dimension

               def self.unpack(hDimension, responseObj)

                  # return nil object if input is empty
                  if hDimension.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: spatial representation dimension object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDimension = intMetadataClass.newDimension

                  # dimension - dimension type (required)
                  if hDimension.has_key?('dimensionType')
                     unless hDimension['dimensionType'] == ''
                        intDimension[:dimensionType] = hDimension['dimensionType']
                     end
                  end
                  if intDimension[:dimensionType].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: spatial representation dimension type is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # dimension - dimension size (required)
                  if hDimension.has_key?('dimensionSize')
                     unless hDimension['dimensionSize'] == ''
                        intDimension[:dimensionSize] = hDimension['dimensionSize']
                     end
                  end
                  if intDimension[:dimensionSize].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: spatial representation dimension size is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # dimension - resolution {measure}
                  if hDimension.has_key?('resolution')
                     hObject = hDimension['resolution']
                     unless hObject.empty?
                        hReturn = Measure.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intDimension[:resolution] = hReturn
                        end
                     end
                  end

                  # dimension - dimension title
                  if hDimension.has_key?('dimensionTitle')
                     unless hDimension['dimensionTitle'] == ''
                        intDimension[:dimensionTitle] = hDimension['dimensionTitle']
                     end
                  end

                  # dimension - dimension description
                  if hDimension.has_key?('dimensionDescription')
                     unless hDimension['dimensionDescription'] == ''
                        intDimension[:dimensionDescription] = hDimension['dimensionDescription']
                     end
                  end

                  return intDimension

               end

            end

         end
      end
   end
end
