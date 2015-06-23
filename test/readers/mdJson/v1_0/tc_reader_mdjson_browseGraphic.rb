# MdTranslator - minitest of
# reader / mdJson / module_browseGraphic

# History:
# Stan Smith 2014-12-24 original script
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set globals used in testing
# set globals used by mdJson_reader.rb before requiring modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                $ReaderNS = ADIWG::Mdtranslator::Readers::MdJson

                @responseObj = {
                    readerVersionUsed: '1.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_browseGraphic'

class TestReaderMdJsonBrowseGraphic_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BrowseGraphic
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'graphicOverview.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_browseGraphic_object

        hIn = @@hIn.clone

        intObj = {
            bGName: 'fileName',
            bGDescription: 'fileDescription',
            bGType: 'fileType',
            bGURI: 'http://thisisanexample.com'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

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

        assert_equal intObj,@@NameSpace.unpack(hIn, @@responseObj)

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

        assert_equal intObj,@@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_browseGraphic_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)

    end

end