# unpack descriptive keyword
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-18 original script
# 	Stan Smith 2013-11-27 modified to process single keyword collection
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-21 removed thesaurus link; replaced by onlineResource to citation
#   Stan Smith 2014-08-21 removed extra level of encapsulation "citation" under "thesaurus"
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-08-24 added return if input hash is empty

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DescriptiveKeyword

                    def self.unpack(hDesKeyword, responseObj)

                        # return nil object if input is empty
                        intKeyword = nil
                        return if hDesKeyword.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intKeyword = intMetadataClass.newKeyword

                        # descriptive keyword - keyword array
                        if hDesKeyword.has_key?('keyword')
                            aKeywords = hDesKeyword['keyword']
                            if aKeywords.length > 0
                                aKeywords.each do |keyword|
                                    intKeyword[:keyword] << keyword
                                end
                            else
                                responseObj[:readerExecutionMessages] << 'Keyword list is empty'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Keyword list is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # descriptive keyword - keyType
                        if hDesKeyword.has_key?('keywordType')
                            s = hDesKeyword['keywordType']
                            if s != ''
                                intKeyword[:keywordType] = s
                            end
                        end

                        # descriptive keyword - thesaurus
                        if hDesKeyword.has_key?('thesaurus')
                            hCitation = hDesKeyword['thesaurus']
                            unless hCitation.empty?
                                intKeyword[:keyTheCitation] = Citation.unpack(hCitation, responseObj)
                            end

                        end

                        return intKeyword
                    end

                end

            end
        end
    end
end
