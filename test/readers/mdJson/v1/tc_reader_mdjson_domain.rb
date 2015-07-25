# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
# Stan Smith 2015-01-20 original script
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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_domain'

class TestReaderMdJsonDomain_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Domain
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
    @@hIn = aIn[0]['domain'][0]

    def test_complete_domain_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:domainId],          'domainId1'
        assert_equal metadata[:domainName],        'commonName1'
        assert_equal metadata[:domainCode],        'codeName1'
        assert_equal metadata[:domainDescription], 'description1'
        refute_empty metadata[:domainItems]
    end

    def test_empty_domain_id
        hIn = @@hIn.clone
        hIn['domainId'] = ''
        hResponse = @@responseObj
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domain_codeName
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['codeName'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domain_description
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['description'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domain_member
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['member'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_domain_elements
        hIn = @@hIn.clone
        hIn['commonName'] = ''
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:domainName]
    end

    def test_missing_domain_elements
        hIn = @@hIn.clone
        hIn.delete('commonName')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata[:domainName]
    end

    def test_empty_domain_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
