# unpack a data dictionary domain
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-23 added error reporting of missing items

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_domainItem')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Domain

                    def self.unpack(hDomain, responseObj)

                        # return nil object if input is empty
                        intDomain = nil
                        return if hDomain.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDomain = intMetadataClass.newDictionaryDomain

                        # data dictionary domain - id
                        if hDomain.has_key?('domainId')
                            s = hDomain['domainId']
                            if s != ''
                                intDomain[:domainId] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain ID is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data dictionary domain - name
                        if hDomain.has_key?('commonName')
                            s = hDomain['commonName']
                            if s != ''
                                intDomain[:domainName] = s
                            end
                        end

                        # data dictionary domain - code
                        if hDomain.has_key?('codeName')
                            s = hDomain['codeName']
                            if s != ''
                                intDomain[:domainCode] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain code name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data dictionary domain - description
                        if hDomain.has_key?('description')
                            s = hDomain['description']
                            if s != ''
                                intDomain[:domainDescription] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain description is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data dictionary domain - members
                        if hDomain.has_key?('member')
                            aDoItems = hDomain['member']
                            unless aDoItems.empty?
                                aDoItems.each do |hDoItem|
                                    intDomain[:domainItems] << DomainItem.unpack(hDoItem, responseObj)
                                end
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain has no members'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intDomain
                    end

                end

            end
        end
    end
end
