# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_onlineResource'

class TestReaderMdJsonOnlineResource < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OnlineResource
    aIn = TestReaderMdJsonParent.getJson('onlineResource.json')
    @@hIn = aIn['onlineResource'][0]

    def test_onlineResource_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'onlineResource.json')
        assert_empty errors

    end

    def test_complete_onlineResource_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'http://http://ISO.uri/adiwg/0',metadata[:olResURI]
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
