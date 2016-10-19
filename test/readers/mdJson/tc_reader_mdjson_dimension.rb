# MdTranslator - minitest of
# reader / mdJson / module_dimension

# History:
#   Stan Smith 2016-10-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_dimension'

class TestReaderMdJsonDimension < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Dimension
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'dimension.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['dimension'][0]

    def test_complete_dimension_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'dimensionType', metadata[:dimensionType]
        assert_equal 9, metadata[:dimensionSize]
        refute_empty metadata[:resolution]
        assert_equal 'dimensionTitle', metadata[:dimensionTitle]
        assert_equal 'dimensionDescription', metadata[:dimensionDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_empty_dimensionType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['dimensionType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_missing_dimensionType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('dimensionType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_empty_dimensionSize

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['dimensionSize'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_missing_dimensionSize

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('dimensionSize')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resolution'] = {}
        hIn['dimensionTitle'] = ''
        hIn['dimensionDescription'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'dimensionType', metadata[:dimensionType]
        assert_equal 9, metadata[:dimensionSize]
        assert_empty metadata[:resolution]
        assert_nil metadata[:dimensionTitle]
        assert_nil metadata[:dimensionDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_dimension_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resolution')
        hIn.delete('dimensionTitle')
        hIn.delete('dimensionDescription')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'dimensionType', metadata[:dimensionType]
        assert_equal 9, metadata[:dimensionSize]
        assert_empty metadata[:resolution]
        assert_nil metadata[:dimensionTitle]
        assert_nil metadata[:dimensionDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_additionalDocumentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
