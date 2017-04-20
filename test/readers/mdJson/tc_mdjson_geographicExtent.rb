# MdTranslator - minitest of
# reader / mdJson / module_geographicExtent

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-10 added computedBbox
#   Stan Smith 2016-10-26 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicExtent'

class TestReaderMdJsonGeographicExtent < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicExtent
    aIn = TestReaderMdJsonParent.getJson('geographicExtent.json')
    @@hIn = aIn['geographicExtent'][0]

    def test_geographicExtent_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'geographicExtent.json')
        assert_empty errors

    end

    def test_complete_geographicExtent

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:containsData]
        refute_empty metadata[:identifier]
        refute_empty metadata[:boundingBox]
        assert_equal 2, metadata[:geographicElements].length
        assert_equal 2, metadata[:nativeGeoJson].length
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_empty_containsData

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['containsData'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert metadata[:containsData]
        refute_empty metadata[:identifier]
        refute_empty metadata[:boundingBox]
        assert_equal 2, metadata[:geographicElements].length
        assert_equal 2, metadata[:nativeGeoJson].length
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_missing_containsData

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('containsData')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert metadata[:containsData]
        refute_empty metadata[:identifier]
        refute_empty metadata[:boundingBox]
        assert_equal 2, metadata[:geographicElements].length
        assert_equal 2, metadata[:nativeGeoJson].length
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['identifier'] = {}
        hIn['boundingBox'] = {}
        hIn['geographicElement'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn.delete('identifier')
        hIn.delete('boundingBox')
        hIn.delete('geographicElement')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_geographicExtent

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
