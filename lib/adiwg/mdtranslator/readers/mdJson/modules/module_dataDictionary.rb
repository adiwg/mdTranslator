# unpack a data dictionary
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-20 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-01 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_domain')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_entity')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DataDictionary

                    def self.unpack(hDictionary, responseObj)

                        # return nil object if input is empty
                        if hDictionary.empty?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDataD = intMetadataClass.newDataDictionary

                        # dictionary - citation {citation} (required)
                        if hDictionary.has_key?('citation')
                            unless  hDictionary['citation'].empty?
                                hCitation = Citation.unpack( hDictionary['citation'], responseObj)
                                unless hCitation.nil?
                                    intDataD[:citation] = hCitation
                                end
                            end
                        end
                        if intDataD[:citation].empty?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary citation is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # dictionary - resource type (required)
                        if hDictionary.has_key?('resourceType')
                            if hDictionary['resourceType'] != ''
                                intDataD[:resourceType] = hDictionary['resourceType']
                            end
                        end
                        if intDataD[:resourceType].nil?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary resource type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # dictionary info - description (required)
                        if hDictionary.has_key?('description')
                            if hDictionary['description'] != ''
                                intDataD[:description] = hDictionary['description']
                            end
                        end
                        if intDataD[:description].nil?
                            responseObj[:readerExecutionMessages] << 'Data Dictionary description is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # dictionary - language
                        if hDictionary.has_key?('language')
                            if hDictionary['language'] != ''
                                intDataD[:language] = hDictionary['language']
                            end
                        end

                        # dictionary - dictionary included with resource
                        if hDictionary.has_key?('dictionaryIncludedWithResource')
                            if hDictionary['dictionaryIncludedWithResource'] === true
                                intDataD[:includedWithDataset] = hDictionary['dictionaryIncludedWithResource']
                            end
                        end

                        # dictionary - domains []
                        if hDictionary.has_key?('domain')
                            aDomains = hDictionary['domain']
                            aDomains.each do |item|
                                hDomain = Domain.unpack(item, responseObj)
                                unless hDomain.nil?
                                    intDataD[:domains] << hDomain
                                end
                            end
                        end

                        # dictionary - entity []
                        if hDictionary.has_key?('entity')
                            aEntities = hDictionary['entity']
                            aEntities.each do |hEntity|
                                unless hEntity.empty?
                                    intDataD[:entities] << Entity.unpack(hEntity, responseObj)
                                end
                            end
                        end

                        return intDataD

                    end

                end
            end
        end
    end
end