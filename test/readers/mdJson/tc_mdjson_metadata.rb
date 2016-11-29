# MdTranslator - minitest of
# reader / mdJson / module_metadata

# History:
#   Stan Smith 2016-10-21 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadata'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
                module MdJson

                    # create new internal metadata container for the reader
                    intMetadataClass = InternalMetadata.new
                    intObj = intMetadataClass.newBase

                    # first contact
                    intObj[:contacts] << intMetadataClass.newContact
                    intObj[:contacts][0][:contactId] = 'individualId0'
                    intObj[:contacts][0][:isOrganization] = false

                    @contacts = intObj[:contacts]

                end
            end
        end
    end
end

class TestReaderMdJsonMetadata < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Metadata
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'metadata.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['metadata'][0]

    def test_complete_metadata_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:metadataInfo]
        refute_empty metadata[:resourceInfo]
        assert_equal 2, metadata[:lineageInfo].length
        assert_equal 2, metadata[:distributorInfo].length
        assert_equal 2, metadata[:associatedResources].length
        assert_equal 2, metadata[:additionalDocuments].length
        assert_equal 2, metadata[:funding].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_empty_metadataInfo

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataInfo'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_missing_metadataInfo

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('metadataInfo')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_empty_resourceInfo

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceInfo'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_missing_resourceInfo

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceInfo')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceLineage'] = []
        hIn['resourceDistribution'] = []
        hIn['associatedResource'] = []
        hIn['additionalDocumentation'] = []
        hIn['funding'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:metadataInfo]
        refute_empty metadata[:resourceInfo]
        assert_empty metadata[:lineageInfo]
        assert_empty metadata[:distributorInfo]
        assert_empty metadata[:associatedResources]
        assert_empty metadata[:additionalDocuments]
        assert_empty metadata[:funding]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_metadata_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceLineage')
        hIn.delete('resourceDistribution')
        hIn.delete('associatedResource')
        hIn.delete('additionalDocumentation')
        hIn.delete('funding')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:metadataInfo]
        refute_empty metadata[:resourceInfo]
        assert_empty metadata[:lineageInfo]
        assert_empty metadata[:distributorInfo]
        assert_empty metadata[:associatedResources]
        assert_empty metadata[:additionalDocuments]
        assert_empty metadata[:funding]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadata_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
