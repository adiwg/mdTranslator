require_relative 'module_formatSpecification'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResourceFormat

                def self.unpack(hContent, responseObj)
                    @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                    # return nil object if input is empty
                    if hContent.empty?
                        @MessagePath.issueWarning(130, responseObj)
                        return nil
                    end

                    # instance classes needed in script
                    intMetadataClass = InternalMetadata.new
                    intContent = intMetadataClass.newresourceFormat

                    # content information - format specification (required)
                    if hContent.has_key?('formatSpecification')
                        hObject = hContent['formatSpecification']
                        unless hObject.empty?
                            hReturn = Format.unpack(hObject, responseObj)
                            unless hReturn.nil?
                                intContent[:formatSpecification] = hReturn
                            end
                        end
                    end

                    # content information - amendment number
                    if hContent.has_key?('amendmentNumber')
                        unless hContent['amendmentNumber'] == ''
                        intContent[:amendmentNumber] = hContent['amendmentNumber']
                        end
                    end
                    if intContent[:amendmentNumber].nil?
                        @MessagePath.issueError(132, responseObj)
                    end

                    # content information - compression method
                    if hContent.has_key?('compressionMethod')
                        unless hContent['compressionMethod'] == ''
                        intContent[:compressionMethod] = hContent['compressionMethod']
                        end
                    end
                    if intContent[:compressionMethod].nil?
                        @MessagePath.issueError(131, responseObj)
                    end

                    # content information - technical prerequisite
                    if hContent.has_key?('technicalPrerequisite')
                        unless hContent['technicalPrerequisite'] == ''
                        intContent[:technicalPrerequisite] = hContent['technicalPrerequisite']
                        end
                    end
                    if intContent[:technicalPrerequisite].nil?
                        @MessagePath.issueError(131, responseObj)
                    end

                    return intContent

                end

            end

         end
      end
   end
end
