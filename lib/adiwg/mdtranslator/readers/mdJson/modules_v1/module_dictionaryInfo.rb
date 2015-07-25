# unpack data dictionary information section
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-24 added error reporting of missing items

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DictionaryInfo

                    def self.unpack(hDictInfo, responseObj)

                        # return nil object if input is empty
                        intDictInfo = nil
                        return if hDictInfo.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDictInfo = intMetadataClass.newDictionaryInfo

                        # dictionary info - citation
                        if hDictInfo.has_key?('citation')
                            hCitation = hDictInfo['citation']
                            unless hCitation.empty?
                                intDictInfo[:dictCitation] = Citation.unpack(hCitation, responseObj)
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary citation is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # dictionary info - description
                        if hDictInfo.has_key?('description')
                            s = hDictInfo['description']
                            if s != ''
                                intDictInfo[:dictDescription] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary description is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # dictionary info - resource type
                        if hDictInfo.has_key?('resourceType')
                            s = hDictInfo['resourceType']
                            if s != ''
                                intDictInfo[:dictResourceType] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary resource type is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # dictionary info - language
                        if hDictInfo.has_key?('language')
                            s = hDictInfo['language']
                            if s != ''
                                intDictInfo[:dictLanguage] = s
                            end
                        end

                        return intDictInfo
                    end

                end

            end
        end
    end
end