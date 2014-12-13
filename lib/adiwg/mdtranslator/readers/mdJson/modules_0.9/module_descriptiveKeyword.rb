# unpack descriptive keyword
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-18 original script
# 	Stan Smith 2013-11-27 modified to process single keyword collection
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-21 removed thesaurus link; replaced by onlineResource to citation
#   Stan Smith 2014-08-21 removed extra level of encapsulation "citation" under "thesaurus"

require ADIWG::Mdtranslator.reader_module('module_citation', $response[:readerVersionUsed])

module Md_DescriptiveKeyword

    def self.unpack(hDesKeyword)

        # instance classes needed in script
        intMetadataClass = InternalMetadata.new
        intKeyword = intMetadataClass.newKeyword

        # descriptive keyword - keyword array
        if hDesKeyword.has_key?('keyword')
            aKeywords = hDesKeyword['keyword']
            aKeywords.each do |keyword|
                intKeyword[:keyword] << keyword
            end
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
                intKeyword[:keyTheCitation] = Md_Citation.unpack(hCitation)
            end

        end

        return intKeyword
    end

end
