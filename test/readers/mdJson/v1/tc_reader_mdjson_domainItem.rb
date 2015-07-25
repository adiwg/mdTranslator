# MdTranslator - minitest of
# reader / mdJson / module_domainItem

# History:
# Stan Smith 2015-07-23 original script

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_domainItem'

class TestReaderMdJsonDomainItem_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DomainItem
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'dataDictionary.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['domain'][0]['member'][0]

    def test_complete_domainItem_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:itemName],       'name11'
        assert_equal metadata[:itemValue],      'value11'
        assert_equal metadata[:itemDefinition], 'definition11'
    end

    def test_empty_domainItem_name
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['name'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domainItem_value
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['value'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domainItem_definition
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['definition'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domainItem_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
