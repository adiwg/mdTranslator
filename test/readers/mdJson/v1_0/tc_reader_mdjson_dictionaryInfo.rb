# MdTranslator - minitest of
# reader / mdJson / module_dictionaryInfo

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
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_dictionaryInfo'

class TestReaderMdJsonDictionaryInfo_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DictionaryInfo
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'dataDictionary.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['dictionaryInfo']

    def test_complete_dictionaryInfo_object

        hIn = @@hIn.clone

        # delete citation
        # citation is tested in tc_reader_mdjson_citation.rb
        hIn.delete('citation')

        intObj = {
            dictCitation: {},
            dictDescription: 'description',
            dictResourceType: 'resourceType',
            dictLanguage: 'language'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_dictionaryInfo_elements

        hIn = @@hIn.clone
        hIn['citation'] = {}
        hIn['description'] = ''
        hIn['resourceType'] = ''
        hIn['language'] = ''

        intObj = {
            dictCitation: {},
            dictDescription: nil,
            dictResourceType: nil,
            dictLanguage: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_dictionaryInfo_elements

        # except for citation
        hIn = @@hIn.clone
        hIn['citation'] = {}
        hIn.delete('description')
        hIn.delete('resourceType')
        hIn.delete('language')

        intObj = {
            dictCitation: {},
            dictDescription: nil,
            dictResourceType: nil,
            dictLanguage: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_dictionaryInfo_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)

    end

end
