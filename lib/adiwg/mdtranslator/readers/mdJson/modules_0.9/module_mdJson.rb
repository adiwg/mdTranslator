# unpack address
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-12-12 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require $ReaderNS.readerModule('module_contacts')
require $ReaderNS.readerModule('module_metadata')
require $ReaderNS.readerModule('module_dataDictionary')
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                def self.unpack(hMdJson)

                    # instance classes needed in script
                    intMetadataClass = InternalMetadata.new

                    # create new internal metadata container for the reader
                    intObj = intMetadataClass.newBase

                    # get json schema name and version
                    hVersion = hMdJson['version']
                    intObj[:jsonVersion][:name] = hVersion['name']
                    intObj[:jsonVersion][:version] = hVersion['version']

                    # contact array
                    # load the array of contacts from the json input
                    # ... the program uses the 'contactId' provided by the user
                    # ... to reference a contact
                    if hMdJson.has_key?('contact')
                    	aContacts = hMdJson['contact']
                    	aContacts.each do |hContact|
                    		unless hContact.empty?
                    			intObj[:contacts] << $ReaderNS::Contact.unpack(hContact)
                    		end
                    	end
                    end

                    # add default contacts
                    intObj[:contacts].concat($ReaderNS::Contact.setDefaultContacts)

                    # metadata
                    # load metadata from the hash object
                    if hMdJson.has_key?('metadata')
                    	hMetadata = hMdJson['metadata']
                    	intObj[:metadata] = $ReaderNS::Metadata.unpack(hMetadata)
                    end

                    # data dictionary
                    if hMdJson.has_key?('dataDictionary')
                    	hDictionary = hMdJson['dataDictionary']
                    	intObj[:dataDictionary] = $ReaderNS::DataDictionary.unpack(hDictionary)
                    end

                    # return ADIwg internal container
                    return intObj

                end

            end
        end
    end
end

