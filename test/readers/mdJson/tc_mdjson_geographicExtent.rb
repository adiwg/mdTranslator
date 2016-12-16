# MdTranslator - minitest of
# reader / mdJson / module_geographicExtent

# History:
#   Stan Smith 2016-11-10 added computedBbox
#   Stan Smith 2016-10-26 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicExtent'

class TestReaderMdJsonGeographicExtent < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicExtent
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'geographicExtent.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['geographicExtent'][0]

    def test_complete_geographicExtent

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:containsData]
        refute_empty metadata[:identifier]
        refute_empty metadata[:boundingBox]
        refute_empty metadata[:geographicElement]
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
        refute_empty metadata[:geographicElement]
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
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_invalid_containsData

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['containsData'] = 'invalid'
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert metadata[:containsData]
        refute_empty metadata[:identifier]
        refute_empty metadata[:boundingBox]
        refute_empty metadata[:geographicElement]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geographicExtent_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hIn['identifier'] = {}
        hIn['boundingBox'] = {}
        hIn['geographicElement'] = {}
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