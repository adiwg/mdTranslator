# unpack keywordObject
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-12-09 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module KeywordObject

                    def self.unpack(hKeyObj, responseObj)

                        # return nil object if input is empty
                        if hKeyObj.empty?
                            responseObj[:readerExecutionMessages] << 'Keyword object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intKeyObj = intMetadataClass.newKeywordObject

                        # keyword object - keyword (required)
                        if hKeyObj.has_key?('keyword')
                            if hKeyObj['keyword'] != ''
                                intKeyObj[:keyword] = hKeyObj['keyword']
                            end
                        end
                        if intKeyObj[:keyword].nil?
                            responseObj[:readerExecutionMessages] << 'Keyword object is missing keyword'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # keyword object - keyword id
                        if hKeyObj.has_key?('keywordId')
                            if hKeyObj['keywordId'] != ''
                                intKeyObj[:keywordId] = hKeyObj['keywordId']
                            end
                        end

                        return intKeyObj

                    end

                end

            end
        end
    end
end
