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

    def test_complete_geoJson

        aIn = Marshal::load(Marshal.dump(@@aIn))
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
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
