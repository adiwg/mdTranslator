# MdTranslator - minitest of
# reader / mdJson / module_featureCollection

# History:
#   Stan Smith 2016-11-10 added computedBbox computation
#   Stan Smith 2016-10-25 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_featureCollection'

class TestReaderMdJsonFeatureCollection < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::FeatureCollection
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'featureCollection.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['featureCollection'][0]

    def test_complete_featureCollection

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'FeatureCollection', metadata[:type]
        refute_empty metadata[:bbox]
        refute_empty metadata[:features]
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_empty_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_missing_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('type')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_empty_features

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['features'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'FeatureCollection', metadata[:type]
        refute_empty metadata[:bbox]
        assert_empty metadata[:features]
        assert_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_missing_features

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('features')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['bbox'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'FeatureCollection', metadata[:type]
        assert_empty metadata[:bbox]
        refute_empty metadata[:features]
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_featureCollection_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('bbox')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'FeatureCollection', metadata[:type]
        assert_empty metadata[:bbox]
        refute_empty metadata[:features]
        refute_empty metadata[:computedBbox]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_featureCollection

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
