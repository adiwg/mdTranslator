# MdTranslator - minitest of
# reader / mdJson / module_associatedResource

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2014-12-30 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_associatedResource'

class TestReaderMdJsonAssociatedResource < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AssociatedResource
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'associatedResource.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['associatedResource'][0]

    def test_complete_associatedResource

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'resourceType', metadata[:resourceType]
        assert_equal 'associationType', metadata[:associationType]
        assert_equal 'initiativeType', metadata[:initiativeType]
        refute_empty metadata[:resourceCitation]
        refute_empty metadata[:metadataCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_empty_resourceType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_missing_resourceType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_empty_associationType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['associationType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_missing_associationType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('associationType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_empty_citations

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceCitation'] = {}
        hIn['metadataCitation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_missing_citations

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceCitation')
        hIn.delete('metadataCitation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_empty_resourceCitation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceCitation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_associatedResource_empty_metadataCitation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataCitation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'resourceType', metadata[:resourceType]
        assert_equal 'associationType', metadata[:associationType]
        assert_equal 'initiativeType', metadata[:initiativeType]
        refute_empty metadata[:resourceCitation]
        assert_empty metadata[:metadataCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_associatedResource_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
