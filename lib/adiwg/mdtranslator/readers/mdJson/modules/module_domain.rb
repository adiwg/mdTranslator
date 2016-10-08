# unpack a data dictionary domain
# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-07-23 added error reporting of missing items
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_domainItem')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Domain

                    def self.unpack(hDomain, responseObj)

                        # return nil object if input is empty
                        if hDomain.empty?
                            responseObj[:readerExecutionMessages] << 'Domain Member object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDomain = intMetadataClass.newDictionaryDomain

                        # data dictionary domain - id (required)
                        if hDomain.has_key?('domainId')
                            intDomain[:domainId] = hDomain['domainId']
                        end
                        if intDomain[:domainId].nil? || intDomain[:domainId] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary domain ID is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # data dictionary domain - name
                        if hDomain.has_key?('commonName')
                            if hDomain['commonName'] != ''
                                intDomain[:domainName] = hDomain['commonName']
                            end
                        end

                        # data dictionary domain - code (required)
                        if hDomain.has_key?('codeName')
                            intDomain[:domainCode] = hDomain['codeName']
                        end
                        if intDomain[:domainCode].nil? || intDomain[:domainCode] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary domain code name is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # data dictionary domain - description (required)
                        if hDomain.has_key?('description')
                            intDomain[:domainDescription] = hDomain['description']
                        end
                        if intDomain[:domainDescription].nil? || intDomain[:domainDescription] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary domain description is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # data dictionary domain - items [] (required)
                        # return nil if no domain item is provided
                        if hDomain.has_key?('domainItem')
                            hDomain['domainItem'].each do |hDoItem|
                                intDomain[:domainItems] << DomainItem.unpack(hDoItem, responseObj)
                            end
                        else
                            intDomain[:domainItems] = []
                        end
                        if intDomain[:domainItems].empty?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary domain has no domain items'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intDomain

                    end

                end

            end
        end
    end
end
