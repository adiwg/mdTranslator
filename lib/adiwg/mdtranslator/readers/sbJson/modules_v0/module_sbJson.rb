require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_contacts')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_metadata')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_dataDictionary')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                def self.unpack(intObj, hSbJson, responseObj)

                    # get json schema name and version
                    hVersion = hSbJson['version']
                    intObj[:schema][:name] = hVersion['name']
                    intObj[:schema][:version] = hVersion['version']

                    # contact array
                    # load the array of contacts from the json input
                    if hSbJson.has_key?('contacts')
                    	aContacts = hSbJson['contacts']
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
                    intObj[:metadata] = Metadata.unpack(hSbJson, responseObj, intObj)

                    # # data dictionary section
                    # if hSbJson.has_key?('dataDictionary')
                    #     aDictionary = hSbJson['dataDictionary']
                    #     aDictionary.each do |hDictionary|
                    #         unless hDictionary.empty?
                    #             intObj[:dataDictionary] << DataDictionary.unpack(hDictionary, responseObj)
                    #         end
                    #     end
                    # end

                    # return ADIwg internal container
                    return intObj

                end

            end
        end
    end
end
