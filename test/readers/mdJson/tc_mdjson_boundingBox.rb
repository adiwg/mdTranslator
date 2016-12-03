# MdTranslator - minitest of
# reader / mdJson / module_boundingBox

# History:
#   Stan Smith 2016-12-02 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_boundingBox'

class TestReaderMdJsonBoundingBox < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BoundingBox
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'boundingBox.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    hIn = JSON.parse(jsonFile)
    @@hIn = hIn['boundingBox'][0]

    def test_complete_boundingBox

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal -140, metadata[:westLongitude]
        assert_equal -120, metadata[:eastLongitude]
        assert_equal 49, metadata[:southLatitude]
        assert_equal 70, metadata[:northLatitude]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_empty_west

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['westLongitude'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_empty_east

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['eastLongitude'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_empty_south

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['southLatitude'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_empty_north

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['northLatitude'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_missing_west

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('westLongitude')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_missing_east

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('eastLongitude')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_missing_south

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('southLatitude')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_missing_north

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('northLatitude')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_west_outOfBounds

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['westLongitude'] = 200
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_east_outOfBounds

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['eastLongitude'] = 200
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_south_outOfBounds

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['southLatitude'] = 200
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_boundingBox_north_outOfBounds

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['northLatitude'] = 200
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_boundingBox_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
