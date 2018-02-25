# unpack format
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2018-02-05 add 'technicalPrerequisite'
# 	Stan Smith 2016-10-20 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Format

               def self.unpack(hFormat, responseObj)

                  # return nil object if input is empty
                  if hFormat.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson distribution media format object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intFormat = intMetadataClass.newResourceFormat

                  # format - format specification {citation} (required)
                  if hFormat.has_key?('formatSpecification')
                     hObject = hFormat['formatSpecification']
                     unless hObject.empty?
                        hReturn = Citation.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intFormat[:formatSpecification] = hReturn
                        end
                     end
                  end
                  if intFormat[:formatSpecification].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson distribution media format specification is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # format - amendment number
                  if hFormat.has_key?('amendmentNumber')
                     unless hFormat['amendmentNumber'] == ''
                        intFormat[:amendmentNumber] = hFormat['amendmentNumber']
                     end
                  end

                  # format - compression method
                  if hFormat.has_key?('compressionMethod')
                     unless hFormat['compressionMethod'] == ''
                        intFormat[:compressionMethod] = hFormat['compressionMethod']
                     end
                  end

                  # format - compression method
                  if hFormat.has_key?('technicalPrerequisite')
                     unless hFormat['technicalPrerequisite'] == ''
                        intFormat[:technicalPrerequisite] = hFormat['technicalPrerequisite']
                     end
                  end

                  return intFormat

               end

            end

         end
      end
   end
end
