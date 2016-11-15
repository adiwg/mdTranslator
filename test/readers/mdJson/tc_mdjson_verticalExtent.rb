# MdTranslator - minitest of
# reader / mdJson / module_verticalExtent

# History:
#   Stan Smith 2016-10-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_verticalExtent'

class TestReaderMdJsonVerticalExtent < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::VerticalExtent
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'verticalExtent.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['verticalExtent'][0]

    def test_complete_vertical_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_equal 9.9, metadata[:minValue]
        assert_equal 9.9, metadata[:maxValue]
        refute_empty metadata[:crsId]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_empty_minValue

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['minValue'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_missing_minValue

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('minValue')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_empty_maxValue

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['maxValue'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_missing_maxValue

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('maxValue')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_empty_crs

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['crsId'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_missing_crs

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('crsId')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:description]
        assert_equal 9.9, metadata[:minValue]
        assert_equal 9.9, metadata[:maxValue]
        refute_empty metadata[:crsId]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_vertical_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:description]
        assert_equal 9.9, metadata[:minValue]
        assert_equal 9.9, metadata[:maxValue]
        refute_empty metadata[:crsId]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_vertical_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
