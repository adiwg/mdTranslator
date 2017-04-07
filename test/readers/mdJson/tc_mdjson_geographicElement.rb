# MdTranslator - minitest of
# reader / mdJson / module_geographicElement

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-12-02 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicElement'

class TestReaderMdJsonGeographicElement < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicElement
    aIn = TestReaderMdJsonParent.getJson('geoJson.json')
    @@aIn = aIn['geographicElement']

    def test_geographicElement_Point

        aIn = Marshal::load(Marshal.dump(@@aIn[0]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_LineString

        aIn = Marshal::load(Marshal.dump(@@aIn[1]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_Polygon

        aIn = Marshal::load(Marshal.dump(@@aIn[2]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_Polygon_interiorRing

        aIn = Marshal::load(Marshal.dump(@@aIn[3]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_MultiPoint

        aIn = Marshal::load(Marshal.dump(@@aIn[4]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_MultiLineString

        aIn = Marshal::load(Marshal.dump(@@aIn[5]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_MultiPolygon

        aIn = Marshal::load(Marshal.dump(@@aIn[6]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_GeometryCollection

        aIn = Marshal::load(Marshal.dump(@@aIn[7]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_Feature

        aIn = Marshal::load(Marshal.dump(@@aIn[8]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicElement_FeatureCollection

        aIn = Marshal::load(Marshal.dump(@@aIn[9]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_geographicElement_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
