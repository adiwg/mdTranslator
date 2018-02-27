# unpack keywordObject
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2016-12-09 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module KeywordObject

               def self.unpack(hKeyObj, responseObj)

                  # return nil object if input is empty
                  if hKeyObj.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: keyword object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intKeyObj = intMetadataClass.newKeywordObject

                  # keyword object - keyword (required)
                  if hKeyObj.has_key?('keyword')
                     unless hKeyObj['keyword'] == ''
                        intKeyObj[:keyword] = hKeyObj['keyword']
                     end
                  end
                  if intKeyObj[:keyword].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson keyword object is missing keyword'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # keyword object - keyword id
                  if hKeyObj.has_key?('keywordId')
                     unless hKeyObj['keywordId'] == ''
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
