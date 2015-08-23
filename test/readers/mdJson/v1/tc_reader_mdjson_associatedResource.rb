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

class TestReaderMdJsonAssociatedResource_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AssociatedResource
    @@responseObj = {
        readerVersionUsed: '1.0',
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'associatedResource.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party from citation to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]
    @@hIn['resourceCitation']['responsibleParty'] = []
    @@hIn['resourceCitation']['identifier']= []
    @@hIn['metadataCitation']['responsibleParty'] = []
    @@hIn['metadataCitation']['identifier'] = []

    def test_complete_associatedResource_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:associationType], 'associationType'
        assert_equal metadata[:initiativeType],  'initiativeType'
        assert_equal metadata[:resourceType],    'resourceType'
        refute_empty metadata[:resourceCitation]
        refute_empty metadata[:metadataCitation]
    end

    def test_empty_associatedResource_associationType
        hIn = @@hIn.clone
        hIn['associationType'] = ''
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_missing_associatedResource_associationType
        hIn = @@hIn.clone
        hIn.delete('associationType')
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_empty_associatedResource_resourceType
        hIn = @@hIn.clone
        hIn['resourceType'] = ''
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_missing_associatedResource_resourceType
        hIn = @@hIn.clone
        hIn.delete('resourceType')
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
        refute @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]
    end

    def test_empty_associatedResource_elements
        hIn = @@hIn.clone
        hIn['initiativeType'] = ''
        hIn['resourceCitation'] = {}
        hIn['metadataCitation'] = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:associationType], 'associationType'
        assert_nil metadata[:initiativeType]
        assert_equal metadata[:resourceType],    'resourceType'
        assert_empty metadata[:resourceCitation]
        assert_empty metadata[:metadataCitation]
    end

    def test_missing_associatedResource_citation
        hIn = @@hIn.clone
        hIn.delete('initiativeType')
        hIn.delete('resourceCitation')
        hIn.delete('metadataCitation')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:associationType], 'associationType'
        assert_nil metadata[:initiativeType]
        assert_equal metadata[:resourceType],    'resourceType'
        assert_empty metadata[:resourceCitation]
        assert_empty metadata[:metadataCitation]
    end

    def test_empty_associatedResource_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end