# MdTranslator - minitest of
# reader / mdJson / module_associatedResource

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_associatedResource'

class TestReaderMdJsonAssociatedResource_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AssociatedResource
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'associatedResource.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_associatedResource_object

        hIn = @@hIn.clone
        hIn.delete('resourceCitation')
        hIn.delete('metadataCitation')

        intObj = {
            associationType: 'associationType',
            initiativeType: 'initiativeType',
            resourceType: 'resourceType',
            resourceCitation: {},
            metadataCitation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_associatedResource_elements

        hIn = @@hIn.clone
        hIn['associationType'] = ''
        hIn['initiativeType'] = ''
        hIn['resourceType'] = ''
        hIn['resourceCitation'] = {}
        hIn['metadataCitation'] = {}

        intObj = {
            associationType: nil,
            initiativeType: nil,
            resourceType: nil,
            resourceCitation: {},
            metadataCitation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_associatedResource_citation

        # note: except for associationType

        hIn = @@hIn.clone
        hIn.delete('initiativeType')
        hIn.delete('resourceType')
        hIn.delete('resourceCitation')
        hIn.delete('metadataCitation')

        intObj = {
            associationType: 'associationType',
            initiativeType: nil,
            resourceType: nil,
            resourceCitation: {},
            metadataCitation: {}
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_associatedResource_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)

    end

end