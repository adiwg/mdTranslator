# MdTranslator - minitest of
# reader / mdJson / module_additionalDocumentation

# History:
# Stan Smith 2014-12-30 original script
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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_additionalDocumentation'

class TestReaderMdJsonAdditionalDocumentation_v1_0 < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AdditionalDocumentation
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'additionalDocumentation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]


    def test_complete_additionalDocumentation_object

        hIn = @@hIn.clone

        # delete citation
        # citation is tested separately
        hIn.delete('citation')

        intObj = {
            resourceType: 'resourceType',
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_additionalDocumentation_elements

        hIn = @@hIn.clone
        hIn['resourceType'] = ''
        hIn['citation'] = {}

        intObj = {
            resourceType: nil,
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_additionalDocumentation_citation

        # note: except for resourceType

        hIn = @@hIn.clone
        hIn.delete('citation')

        intObj = {
            resourceType: 'resourceType',
            citation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_additionalDocumentation_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @responseObj)

    end

end