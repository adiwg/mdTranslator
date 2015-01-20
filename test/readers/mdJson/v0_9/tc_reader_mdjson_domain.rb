# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
# Stan Smith 2015-01-20 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '0.9',
    readerExecutionPas: true,
    readerExecutionMessages: []
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_domain'

class TestReaderMdJsonDomain_v0_9 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v0_9/examples/dataDictionary.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]['domain'][0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Domain

    def test_complete_domain_object


        hIn = @@hIn.clone
        hIn.delete('member')
        intObj = {
            domainId: 'domainId1',
            domainName: 'commonName1',
            domainCode: 'codeName1',
            domainDescription: 'description1',
            domainItems: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_domain_elements

        hIn = @@hIn.clone
        hIn['domainId'] = ''
        hIn['commonName'] = ''
        hIn['codeName'] = ''
        hIn['description'] = ''
        hIn['member'] = []

        intObj = {
            domainId: nil,
            domainName: nil,
            domainCode: nil,
            domainDescription: nil,
            domainItems: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_domain_elements

        # except for domainId
        hIn = @@hIn.clone
        hIn.delete('commonName')
        hIn.delete('codeName')
        hIn.delete('description')
        hIn.delete('member')

        intObj = {
            domainId: 'domainId1',
            domainName: nil,
            domainCode: nil,
            domainDescription: nil,
            domainItems: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_domain_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end
