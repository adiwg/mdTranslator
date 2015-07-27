# MdTranslator - minitest of
# reader / mdJson / module_browseGraphic

# History:
# Stan Smith 2014-12-24 original script
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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_browseGraphic'

class TestReaderMdJsonBrowseGraphic_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BrowseGraphic
    @@responseObj = {
        readerVersionUsed: '1.0',
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

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
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:bGName], 'fileName'
        assert_equal metadata[:bGDescription], 'fileDescription'
        assert_equal metadata[:bGType], 'fileType'
        assert_equal metadata[:bGURI], 'http://thisisanexample.com'
    end

    def test_empty_browseGraphic_fileName
        hIn = @@hIn.clone
        hIn['fileName'] = ''
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_missing_browseGraphic_fileName
        hIn = @@hIn.clone
        hIn.delete('fileName')
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_empty_browseGraphic_elements
        hIn = @@hIn.clone
        hIn['fileDescription'] = ''
        hIn['fileType'] = ''
        hIn['fileUri'] = ''
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:bGDescription]
        assert_nil metadata[:bGType]
        assert_nil metadata[:bGURI]
    end

    def test_missing_browseGraphic_elements
        hIn = @@hIn.clone
        hIn.delete('fileDescription')
        hIn.delete('fileType')
        hIn.delete('fileUri')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:bGDescription]
        assert_nil metadata[:bGType]
        assert_nil metadata[:bGURI]
    end

    def test_empty_browseGraphic_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end