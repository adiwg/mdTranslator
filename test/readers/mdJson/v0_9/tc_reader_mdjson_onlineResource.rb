# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_onlineResource'

class TestReaderMdJsonOnlineResource_v0_9 < MiniTest::Test

    def test_build_full_onlineResource_object

        json_string = '{ ' +
            '"uri": "http://thisIsAnExample.com", ' +
            '"protocol": "protocol", ' +
            '"name": "Name", ' +
            '"description": "Description", ' +
            '"function": "function"' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = {
            olResURI: 'http://thisIsAnExample.com',
            olResProtocol: 'protocol',
            olResName: 'Name',
            olResDesc: 'Description',
            olResFunction: 'function'
        }

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::OnlineResource.unpack(hIn)

    end

    def test_build_empty_onlineResource_object

        json_string = '{}'
        hIn = JSON.parse(json_string)

        assert_equal nil, ADIWG::Mdtranslator::Readers::MdJson::OnlineResource.unpack(hIn)

    end

end
