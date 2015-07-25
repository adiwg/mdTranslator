# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_onlineResource'

class TestReaderMdJsonOnlineResource_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OnlineResource
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'onlineResource.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_onlineResource_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:olResURI],      'http://thisisanexample.com'
        assert_equal metadata[:olResProtocol], 'protocol'
        assert_equal metadata[:olResName],     'name'
        assert_equal metadata[:olResDesc],     'description'
        assert_equal metadata[:olResFunction], 'function'
    end

    def test_empty_onlineResource_uri
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['uri'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_onlineResource_elements
        hIn = @@hIn.clone
        hIn['protocol'] = ''
        hIn['name'] = ''
        hIn['description'] = ''
        hIn['function'] = ''
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:olResProtocol]
        assert_nil metadata[:olResName]
        assert_nil metadata[:olResDesc]
        assert_nil metadata[:olResFunction]
    end

    def test_missing_onlineResource_elements
        hIn = @@hIn.clone
        hIn.delete('protocol')
        hIn.delete('name')
        hIn.delete('description')
        hIn.delete('function')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:olResProtocol]
        assert_nil metadata[:olResName]
        assert_nil metadata[:olResDesc]
        assert_nil metadata[:olResFunction]
    end

    def test_empty_onlineResource_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
