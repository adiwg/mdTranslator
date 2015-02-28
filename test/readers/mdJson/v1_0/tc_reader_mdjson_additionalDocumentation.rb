# MdTranslator - minitest of
# reader / mdJson / module_additionalDocumentation

# History:
# Stan Smith 2014-12-30 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '1.0'
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_additionalDocumentation'

class TestReaderMdJsonAdditionalDocumentation_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/additionalDocumentation.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AdditionalDocumentation

    def test_complete_additionalDocumentation_object

        hIn = @@hIn.clone
        hIn.delete('citation')

        intObj = {
            resourceType: 'resourceType',
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_additionalDocumentation_elements

        hIn = @@hIn.clone
        hIn['resourceType'] = ''
        hIn['citation'] = {}

        intObj = {
            resourceType: nil,
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_additionalDocumentation_citation

        # note: except for resourceType

        hIn = @@hIn.clone
        hIn.delete('citation')

        intObj = {
            resourceType: 'resourceType',
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_additionalDocumentation_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end