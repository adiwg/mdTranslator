# MdTranslator - minitest of
# reader / mdJson / module_geometryObject

# History:
#   Stan Smith 2016-10-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryObject'

class TestReaderMdJsonGeometryObject < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryObject
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'geometryObject.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['geometryObject']

    def test_complete_geometryObject_Point

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'Point', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryObject_empty_type

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hIn['type'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryObject_missing_type

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hIn.delete('type')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryObject_empty_coordinates

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hIn['coordinates'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryObject_missing_coordinates

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hIn.delete('coordinates')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_LineString

        hIn = Marshal::load(Marshal.dump(@@hIn[1]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'LineString', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_Polygon

        hIn = Marshal::load(Marshal.dump(@@hIn[2]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'Polygon', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_MultiPoint

        hIn = Marshal::load(Marshal.dump(@@hIn[4]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'MultiPoint', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_MultiLineString

        hIn = Marshal::load(Marshal.dump(@@hIn[5]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'MultiLineString', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_MultiPolygon

        hIn = Marshal::load(Marshal.dump(@@hIn[6]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'MultiPolygon', metadata[:type]
        refute_empty metadata[:coordinates]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geometryObject_invalid

        hIn = Marshal::load(Marshal.dump(@@hIn[0]))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_geometryObject

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
