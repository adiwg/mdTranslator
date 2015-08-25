# MdTranslator - minitest of
# reader / mdJson / module_descriptiveKeyword

# History:
# Stan Smith 2015-08-24 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_descriptiveKeyword'

class TestReaderMdJsonDescriptiveKeyword_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DescriptiveKeyword
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'keywords.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party from citation to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]
    @@hIn['thesaurus']['responsibleParty'] = []
    @@hIn['thesaurus']['identifier'][0]['authority']['responsibleParty'] = []

    def test_complete_keyword_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:keyword].length, 2
        assert_equal metadata[:keyword][0],  'keyword1'
        assert_equal metadata[:keyword][1],  'keyword2'
        assert_equal metadata[:keywordType], 'keywordType'
        refute_empty metadata[:keyTheCitation]
    end

    def test_empty_keyword_list
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['keyword'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_missing_keyword_list
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('keyword')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_keyword_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['keywordType'] = ''
        hIn['thesaurus'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:keywordType]
        assert_empty metadata[:keyTheCitation]
    end

    def test_missing_keyword_elements
        hIn = @@hIn.clone
        hIn.delete('keywordType')
        hIn.delete('thesaurus')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:keywordType]
        assert_empty metadata[:keyTheCitation]
    end

    def test_empty_keyword_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
