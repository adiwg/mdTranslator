# unpack keyword
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
#  Stan Smith 2016-10-23 refactored for mdJson 2.0
#  Stan Smith 2015-08-24 added return if input hash is empty
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-08-21 removed extra level of encapsulation "citation" under "thesaurus"
#  Stan Smith 2014-08-21 removed thesaurus link; replaced by onlineResource to citation
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2013-11-27 modified to process single keyword collection
# 	Stan Smith 2013-09-18 original script

require_relative 'module_citation'
require_relative 'module_keywordObject'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Keyword

               def self.unpack(hKeyword, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hKeyword.empty?
                     @MessagePath.issueWarning(470, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intKeyword = intMetadataClass.newKeyword

                  outContext = 'keywords'

                  # keyword - keyword [] (required)
                  if hKeyword.has_key?('keyword')
                     hKeyword['keyword'].each do |hItem|
                        unless hItem.empty?
                           hReturn = KeywordObject.unpack(hItem, responseObj)
                           unless hReturn.nil?
                              intKeyword[:keywords] << hReturn
                           end
                        end
                     end
                  end
                  if intKeyword[:keywords].empty?
                     @MessagePath.issueError(471, responseObj)
                  end

                  # keyword - keyType
                  if hKeyword.has_key?('keywordType')
                     unless hKeyword['keywordType'] == ''
                        intKeyword[:keywordType] = hKeyword['keywordType']
                     end
                  end

                  # keyword - thesaurus {citation}
                  if hKeyword.has_key?('thesaurus')
                     hObject = hKeyword['thesaurus']
                     unless hObject.empty?
                        hReturn = Citation.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intKeyword[:thesaurus] = hReturn
                        end
                     end
                  end

                  return intKeyword

               end

            end

         end
      end
   end
end
