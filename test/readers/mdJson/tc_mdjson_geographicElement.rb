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

    def test_complete_geographicElement

        aIn = Marshal::load(Marshal.dump(@@aIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(aIn, hResponse)

        refute_empty metadata[:nativeGeoJson]
        refute_empty metadata[:geographicElements]
        refute_empty metadata[:computedBbox]
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
