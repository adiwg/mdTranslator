# MdTranslator - minitest of
# reader / mdJson / module_graphic

# History:
#   Stan Smith 2016-10-11 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2014-12-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_graphic'

class TestReaderMdJsonGraphic < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Graphic
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'graphic.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['graphic'][0]

    def test_complete_graphic_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'fileName', metadata[:graphicName]
        assert_equal 'fileDescription', metadata[:graphicDescription]
        assert_equal 'fileType', metadata[:graphicType]
        assert_empty metadata[:graphicConstraint]
        assert_equal 1, metadata[:graphicURI].length

    end

    def test_empty_graphic_fileName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['fileName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_graphic_fileName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('fileName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_graphic_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['fileDescription'] = ''
        hIn['fileType'] = ''
        hIn['fileConstraint'] = []
        hIn['fileUri'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:graphicDescription]
        assert_nil metadata[:graphicType]
        assert_empty metadata[:graphicConstraint]
        assert_empty metadata[:graphicURI]

    end

    def test_missing_graphic_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('fileDescription')
        hIn.delete('fileType')
        hIn.delete('fileConstraint')
        hIn.delete('fileUri')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:graphicDescription]
        assert_nil metadata[:graphicType]
        assert_empty metadata[:graphicConstraint]
        assert_empty metadata[:graphicURI]

    end

    def test_empty_graphic_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata

    end

end
