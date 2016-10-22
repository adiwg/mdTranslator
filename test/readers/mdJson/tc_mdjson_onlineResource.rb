# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
# Stan Smith 2016-10-03 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_onlineResource'

class TestReaderMdJsonOnlineResource < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OnlineResource
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'onlineResource.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['onlineResource'][0]

    def test_complete_onlineResource_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'http://URI.example.com',metadata[:olResURI]
        assert_equal 'protocol', metadata[:olResProtocol]
        assert_equal 'name', metadata[:olResName]
        assert_equal 'description', metadata[:olResDesc]
        assert_equal 'function', metadata[:olResFunction]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]


    end

    def test_empty_onlineResource_uri

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['uri'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_onlineResource_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['protocol'] = ''
        hIn['name'] = ''
        hIn['description'] = ''
        hIn['function'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:olResProtocol]
        assert_nil metadata[:olResName]
        assert_nil metadata[:olResDesc]
        assert_nil metadata[:olResFunction]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_onlineResource_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('protocol')
        hIn.delete('name')
        hIn.delete('description')
        hIn.delete('function')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:olResProtocol]
        assert_nil metadata[:olResName]
        assert_nil metadata[:olResDesc]
        assert_nil metadata[:olResFunction]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_onlineResource_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
