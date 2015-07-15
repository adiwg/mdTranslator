# unpack address
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-12-12 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-02-17 added support for multiple data dictionaries
#   Stan Smith 2015-06-12 moved instantiation of intObj up to module mdJson_reader.rb
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_contacts')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_metadata')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dataDictionary')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                def self.unpack(intObj, hMdJson, responseObj)

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
                    			intObj[:contacts] << Contact.unpack(hContact, responseObj)
                    		end
                    	end
                    end

                    # add default contacts
                    intObj[:contacts].concat(Contact.setDefaultContacts)

                    # metadata section
                    # load metadata from the hash object
                    if hMdJson.has_key?('metadata')
                    	hMetadata = hMdJson['metadata']
                    	intObj[:metadata] = Metadata.unpack(hMetadata, responseObj)
                    end

                    # data dictionary section
                    if hMdJson.has_key?('dataDictionary')
                        aDictionary = hMdJson['dataDictionary']
                        aDictionary.each do |hDictionary|
                            unless hDictionary.empty?
                                intObj[:dataDictionary] << DataDictionary.unpack(hDictionary, responseObj)
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

