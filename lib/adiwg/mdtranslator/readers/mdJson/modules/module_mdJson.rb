# unpack mdJson
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-07 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_schema'
require_relative 'module_contact'
require_relative 'module_metadata'
require_relative 'module_dataDictionary'

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
                        intObj = intMetadataClass.newBase

                        # mdJson - schema {schema} (required)
                        if hMdJson.has_key?('schema')
                            hObject = hMdJson['schema']
                            unless hObject.empty?
                                hReturn = Schema.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intObj[:schema] = hReturn
                                end
                            end
                        end
                        if intObj[:schema].empty?
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
                                    intObj[:contacts] << hReturn
                                    @contacts = intObj[:contacts]
                                end
                            end
                        end
                        if intObj[:contacts].empty?
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
                                    intObj[:metadata] = hReturn
                                end
                            end
                        end
                        if intObj[:metadata].empty?
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
                                    intObj[:dataDictionaries] << hReturn
                                end
                            end
                        end

                        return intObj

                    end

                    # find the array pointer for a contact
                    def self.findContact(contactId)

                        contactIndex = nil
                        contactType = nil
                        i = 0
                        @contacts.each do |contact|
                            if contact[:contactId] == contactId
                                contactIndex = i
                                if contact[:isOrganization]
                                    contactType = 'organization'
                                else
                                    contactType = 'individual'
                                end
                            end
                            i += 1
                        end

                        return contactIndex, contactType

                    end

                end

            end
        end
    end
end
