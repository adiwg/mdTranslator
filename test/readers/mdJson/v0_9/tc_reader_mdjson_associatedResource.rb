# MdTranslator - minitest of
# reader / mdJson / module_associatedResource

# History:
# Stan Smith 2014-12-30 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '0.9'
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_associatedResource'

class TestReaderMdJsonAssociatedResource_v0_9 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v0_9/examples/associatedResource.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AssociatedResource

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_associatedResource_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end