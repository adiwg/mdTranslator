# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_onlineResource'

class TestReaderMdJsonOnlineResource_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/onlineResource.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OnlineResource

    def test_complete_onlineResource_object

        hIn = @@hIn.clone

        intObj = {
            olResURI: 'http://thisisanexample.com',
            olResProtocol: 'protocol',
            olResName: 'name',
            olResDesc: 'description',
            olResFunction: 'function'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_onlineResource_elements

        # except for uri

        hIn = @@hIn.clone
        hIn.delete('protocol')
        hIn.delete('name')
        hIn.delete('description')
        hIn.delete('function')

        intObj = {
            olResURI: 'http://thisisanexample.com',
            olResProtocol: nil,
            olResName: nil,
            olResDesc: nil,
            olResFunction: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_onlineResource_elements

        hIn = @@hIn.clone
        hIn['uri'] = ''
        hIn['protocol'] = ''
        hIn['name'] = ''
        hIn['description'] = ''
        hIn['function'] = ''

        intObj = {
            olResURI: nil,
            olResProtocol: nil,
            olResName: nil,
            olResDesc: nil,
            olResFunction: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_onlineResource_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end
