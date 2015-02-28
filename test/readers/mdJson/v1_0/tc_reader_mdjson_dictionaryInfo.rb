# MdTranslator - minitest of
# reader / mdJson / module_dictionaryInfo

# History:
# Stan Smith 2015-01-20 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '1.0',
    readerExecutionPas: true,
    readerExecutionMessages: []
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_dictionaryInfo'

class TestReaderMdJsonDictionaryInfo_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/dataDictionary.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]['dictionaryInfo']

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DictionaryInfo

    def test_complete_dictionaryInfo_object


        hIn = @@hIn.clone
        hIn.delete('citation')
        intObj = {
            dictCitation: {},
            dictDescription: 'description',
            dictResourceType: 'resourceType',
            dictLanguage: 'language'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_dictionaryInfo_elements

        hIn = @@hIn.clone
        hIn['citation'] = {}
        hIn['description'] = ''
        hIn['resourceType'] = ''
        hIn['language'] = ''

        intObj = {
            dictCitation: {},
            dictDescription: nil,
            dictResourceType: nil,
            dictLanguage: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_dictionaryInfo_elements

        # except for citation
        hIn = @@hIn.clone
        hIn['citation'] = {}
        hIn.delete('description')
        hIn.delete('resourceType')
        hIn.delete('language')

        intObj = {
            dictCitation: {},
            dictDescription: nil,
            dictResourceType: nil,
            dictLanguage: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_dictionaryInfo_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end
