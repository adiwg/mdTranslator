# unpack address
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-12-12 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-02-17 added support for multiple data dictionaries
#   Stan Smith 2015-06-12 moved instantiation of intObj up to module mdJson_reader.rb

require $ReaderNS.readerModule('module_contacts')
require $ReaderNS.readerModule('module_metadata')
require $ReaderNS.readerModule('module_dataDictionary')
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                def self.unpack(intObj, hMdJson)

                    # get json schema name and version
                    hVersion = hMdJson['version']
                    intObj[:schema][:name] = hVersion['name']
                    intObj[:schema][:version] = hVersion['version']

                    # contact array
                    # load the array of contacts from the json input
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

                    # metadata section
                    # load metadata from the hash object
                    if hMdJson.has_key?('metadata')
                    	hMetadata = hMdJson['metadata']
                    	intObj[:metadata] = $ReaderNS::Metadata.unpack(hMetadata)
                    end

                    # data dictionary section
                    if hMdJson.has_key?('dataDictionary')
                        aDictionary = hMdJson['dataDictionary']
                        aDictionary.each do |hDictionary|
                            unless hDictionary.empty?
                                intObj[:dataDictionary] << $ReaderNS::DataDictionary.unpack(hDictionary)
                            end
                        end
                    end

                    # return ADIwg internal container
                    return intObj

                end

            end
        end
    end
end

