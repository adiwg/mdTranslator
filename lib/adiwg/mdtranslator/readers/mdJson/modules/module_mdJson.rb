# unpack mdJson
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-07 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_schema')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_contact')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_metadata')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dataDictionary')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module MdJson

                    def self.unpack(hMdJson, responseObj)

                        # return nil object if input is empty
                        if hMdJson.empty?
                            responseObj[:readerExecutionMessages] << 'mdJson object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMdJson = intMetadataClass.newBase

                        # mdJson - schema {schema} (required)
                        if hMdJson.has_key?('schema')
                            hObject = hMdJson['schema']
                            unless hObject.empty?
                                hReturn = Schema.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intMdJson[:schema] = hReturn
                                end
                            end
                        end
                        if intMdJson[:schema].empty?
                            responseObj[:readerExecutionMessages] << 'mdJson object is missing schema'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # mdJson - contact [] {contact} (required)
                        if hMdJson.has_key?('contact')
                            aItems = hMdJson['contact']
                            aItems.each do |item|
                                hReturn = Contact.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMdJson[:contacts] << hReturn
                                end
                            end
                        end
                        if intMdJson[:contacts].empty?
                            responseObj[:readerExecutionMessages] << 'mdJson object is missing contact'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # mdJson - metadata {metadata} (required)
                        if hMdJson.has_key?('metadata')
                            hObject = hMdJson['metadata']
                            unless hObject.empty?
                                hReturn = Metadata.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intMdJson[:metadata] = hReturn
                                end
                            end
                        end
                        if intMdJson[:metadata].empty?
                            responseObj[:readerExecutionMessages] << 'mdJson object is missing metadata'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # mdJson - data dictionary {dataDictionary}
                        if hMdJson.has_key?('dataDictionary')
                            aItems = hMdJson['dataDictionary']
                            aItems.each do |item|
                                hReturn = DataDictionary.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMdJson[:dataDictionaries] << hReturn
                                end
                            end
                        end

                        return intMdJson

                    end

                end

            end
        end
    end
end
