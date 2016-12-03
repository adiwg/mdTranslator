# MdTranslator - minitest of
# reader / mdJson / module_geographicElement

# History:
#   Stan Smith 2016-12-02 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicElement'

class TestReaderMdJsonGeographicElement < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicElement
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'geoJson.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
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
