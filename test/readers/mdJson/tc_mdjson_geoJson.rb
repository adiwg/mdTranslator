# MdTranslator - minitest of
# reader / mdJson / module_geoJson

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-26 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geoJson'

class TestReaderMdJsonGeoJson < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeoJson
    aIn = TestReaderMdJsonParent.getJson('geoJson.json')
    @@aIn = aIn['geographicElement']

    def test_geoJson_schema

        ADIWG::MdjsonSchemas::Utils.load_schemas(false)

        @@aIn.each do |hGeo|
            errors = JSON::Validator.fully_validate('geojson.json', hGeo)
            assert_empty errors
        end

    end

    def test_complete_geoJson_Point

        aIn = Marshal::load(Marshal.dump(@@aIn[0]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_LingString

        aIn = Marshal::load(Marshal.dump(@@aIn[1]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_Polygon

        aIn = Marshal::load(Marshal.dump(@@aIn[2]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_Polygon_interior

        aIn = Marshal::load(Marshal.dump(@@aIn[3]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_MultiPoint

        aIn = Marshal::load(Marshal.dump(@@aIn[4]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_MultiLineString

        aIn = Marshal::load(Marshal.dump(@@aIn[5]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_MultiPolygon

        aIn = Marshal::load(Marshal.dump(@@aIn[6]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_GeometryCollection

        aIn = Marshal::load(Marshal.dump(@@aIn[7]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_Feature

        aIn = Marshal::load(Marshal.dump(@@aIn[8]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_geoJson_FeatureCollection

        aIn = Marshal::load(Marshal.dump(@@aIn[9]))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_geoJson_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        assert hResponse[:readerExecutionPass]
        assert_equal 1, hResponse[:readerExecutionMessages].length
        assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: GeoJSON object is empty'

    end

end
