# MdTranslator - minitest of
# reader / mdJson / module_geoJson

# History:
#   Stan Smith 2016-10-26 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geoJson'

class TestReaderMdJsonGeoJson < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeoJson
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
