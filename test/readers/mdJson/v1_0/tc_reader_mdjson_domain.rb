# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
# Stan Smith 2015-01-20 original script
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set globals used by mdJson_reader.rb before requiring modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                $ReaderNS = ADIWG::Mdtranslator::Readers::MdJson

                @responseObj = {
                    readerVersionUsed: '1.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_domain'

class TestReaderMdJsonDomain_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Domain
    @@responseObj = {}

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
        hIn.delete('member')
        intObj = {
            domainId: 'domainId1',
            domainName: 'commonName1',
            domainCode: 'codeName1',
            domainDescription: 'description1',
            domainItems: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

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

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

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

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_domain_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)

    end

end
