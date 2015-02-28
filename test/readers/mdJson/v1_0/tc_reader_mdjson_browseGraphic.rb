# MdTranslator - minitest of
# reader / mdJson / module_browseGraphic

# History:
# Stan Smith 2014-12-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_browseGraphic'

class TestReaderMdJsonBrowseGraphic_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/graphicOverview.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BrowseGraphic

    def test_complete_browseGraphic_object

        hIn = @@hIn.clone

        intObj = {
            bGName: 'fileName',
            bGDescription: 'fileDescription',
            bGType: 'fileType',
            bGURI: 'http://thisisanexample.com'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_browseGraphic_elements

        # except for fileName

        hIn = @@hIn.clone
        hIn.delete('fileDescription')
        hIn.delete('fileType')
        hIn.delete('fileUri')

        intObj = {
            bGName: 'fileName',
            bGDescription: nil,
            bGType: nil,
            bGURI: nil
        }

        assert_equal intObj,@@NameSpace.unpack(hIn)

    end

    def test_empty_browseGraphic_elements

        hIn = @@hIn.clone
        hIn['fileName'] = ''
        hIn['fileDescription'] = ''
        hIn['fileType'] = ''
        hIn['fileUri'] = ''

        intObj = {
            bGName: nil,
            bGDescription: nil,
            bGType: nil,
            bGURI: nil
        }

        assert_equal intObj,@@NameSpace.unpack(hIn)

    end

    def test_empty_browseGraphic_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end