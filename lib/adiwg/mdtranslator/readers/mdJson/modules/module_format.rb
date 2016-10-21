# unpack format
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-20 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Format

                    def self.unpack(hFormat, responseObj)

                        # return nil object if input is empty
                        if hFormat.empty?
                            responseObj[:readerExecutionMessages] << 'Format object is empty'
                            responseObj[:readerExecutionPass] = false
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
                            responseObj[:readerExecutionMessages] << 'Format is missing formatSpecification'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # format - amendment number
                        if hFormat.has_key?('amendmentNumber')
                            if hFormat['amendmentNumber'] != ''
                                intFormat[:amendmentNumber] = hFormat['amendmentNumber']
                            end
                        end

                        # format - compression method
                        if hFormat.has_key?('compressionMethod')
                            if hFormat['compressionMethod'] != ''
                                intFormat[:compressionMethod] = hFormat['compressionMethod']
                            end
                        end

                        return intFormat

                    end

                end

            end
        end
    end
end
