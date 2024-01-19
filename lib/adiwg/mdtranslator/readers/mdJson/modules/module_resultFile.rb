require_relative 'module_format'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResultFile

                def self.unpack(hContent, responseObj)
                    require 'pp'
                    pp hContent
                    @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                    # return nil object if input is empty
                    if hContent.empty?
                        @MessagePath.issueWarning(130, responseObj)
                        return nil
                    end

                    # instance classes needed in script
                    intMetadataClass = InternalMetadata.new
                    intContent = intMetadataClass.newCoverageDescription

                    # content information - file name (required)
                    if hContent.has_key?('fileName')
                        unless hContent['fileName'] == ''
                        intContent[:fileName] = hContent['fileName']
                        end
                    end
                    if intContent[:fileName].nil?
                        @MessagePath.issueError(131, responseObj)
                    end

                    # content information - file description (required)
                    if hContent.has_key?('fileDescription')
                        unless hContent['fileDescription'] == ''
                        intContent[:fileDescription] = hContent['fileDescription']
                        end
                    end
                    if intContent[:fileDescription].nil?
                        @MessagePath.issueError(132, responseObj)
                    end

                    # content information - file type
                    if hContent.has_key?('fileType')
                        unless hContent['fileType'] == ''
                        intContent[:fileType] = hContent['fileType']
                        end
                    end
                    if intContent[:fileType].nil?
                        @MessagePath.issueError(131, responseObj)
                    end

                    if hContent.has_key?('fileFormat')
                        hObject = hContent['fileFormat']
                        unless hObject.empty?
                            hReturn = Format.unpack(hObject, responseObj)
                            unless hReturn.nil?
                                intContent[:fileFormat] = hReturn
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
