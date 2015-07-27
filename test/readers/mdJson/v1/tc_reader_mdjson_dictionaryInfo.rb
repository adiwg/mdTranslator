# MdTranslator - minitest of
# reader / mdJson / module_dictionaryInfo

# History:
# Stan Smith 2015-01-20 original script
# Stan Smith 2015-06-22 refactored setup to after removal of globals

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_dictionaryInfo'

class TestReaderMdJsonDictionaryInfo_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DictionaryInfo
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'dataDictionary.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party from citation to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]['dictionaryInfo']
    @@hIn['citation']['responsibleParty'] = []

    def test_complete_dictionaryInfo_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        refute_empty metadata[:dictCitation]
        assert_equal metadata[:dictDescription],  'description'
        assert_equal metadata[:dictResourceType], 'resourceType'
        assert_equal metadata[:dictLanguage],     'language'
    end

    def test_empty_dictionaryInfo_citation
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['citation'] = {}
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_dictionaryInfo_description
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['description'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_dictionaryInfo_resourceType
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['resourceType'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_dictionaryInfo_elements
        hIn = @@hIn.clone
        hIn['language'] = ''
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:dictLanguage]
    end

    def test_missing_dictionaryInfo_elements
        hIn = @@hIn.clone
        hIn.delete('language')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:dictLanguage]
    end

    def test_empty_dictionaryInfo_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
