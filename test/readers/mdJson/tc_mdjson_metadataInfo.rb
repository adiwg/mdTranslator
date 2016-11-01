# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
#   Stan Smith 2016-10-31 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadataInfo'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                # create new internal metadata container for the reader
                intMetadataClass = InternalMetadata.new
                @intObj = intMetadataClass.newBase

                # first contact
                @intObj[:contacts] << intMetadataClass.newContact
                @intObj[:contacts][0][:contactId] = 'individualId0'
                @intObj[:contacts][0][:isOrganization] = false

            end
        end
    end
end

class TestReaderMdJsonMetadataInfo < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataInfo
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'metadataInfo.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['metadataInfo'][0]

    def test_complete_metadataInfo_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:metadataIdentifier]
        refute_empty metadata[:parentMetadata]
        refute_empty metadata[:defaultMetadataLocale]
        assert_equal 2, metadata[:otherMetadataLocales].length
        assert_equal 2, metadata[:resourceScopes].length
        assert_equal 2, metadata[:metadataContacts].length
        refute_empty metadata[:metadataCreationDate]
        assert_equal 2, metadata[:otherMetadataDates].length
        assert_equal 2, metadata[:metadataLinkages].length
        refute_empty metadata[:metadataMaintenance]
        assert_equal 2, metadata[:alternateMetadataReferences].length
        assert_equal 'metadataStatus', metadata[:metadataStatus]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataInfo_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataContact'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataInfo_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('metadataContact')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataInfo_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataIdentifier'] = {}
        hIn['parentMetadata'] = {}
        hIn['defaultMetadataLocale'] = {}
        hIn['otherMetadataLocale'] = []
        hIn['resourceScope'] = []
        hIn['metadataCreationDate'] = ''
        hIn['otherMetadataDates'] = []
        hIn['metadataLinkage'] = []
        hIn['metadataMaintenance'] = {}
        hIn['alternateMetadataReference'] = []
        hIn['metadataStatus'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:metadataIdentifier]
        assert_empty metadata[:parentMetadata]
        assert_empty metadata[:defaultMetadataLocale]
        assert_empty metadata[:otherMetadataLocales]
        assert_empty metadata[:resourceScopes]
        assert_equal 2, metadata[:metadataContacts].length
        assert_empty metadata[:metadataCreationDate]
        assert_empty metadata[:otherMetadataDates]
        assert_empty metadata[:metadataLinkages]
        assert_empty metadata[:metadataMaintenance]
        assert_empty metadata[:alternateMetadataReferences]
        assert_nil metadata[:metadataStatus]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataInfo_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('metadataIdentifier')
        hIn.delete('parentMetadata')
        hIn.delete('defaultMetadataLocale')
        hIn.delete('otherMetadataLocale')
        hIn.delete('resourceScope')
        hIn.delete('metadataCreationDate')
        hIn.delete('otherMetadataDates')
        hIn.delete('metadataLinkage')
        hIn.delete('metadataMaintenance')
        hIn.delete('alternateMetadataReference')
        hIn.delete('metadataStatus')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:metadataIdentifier]
        assert_empty metadata[:parentMetadata]
        assert_empty metadata[:defaultMetadataLocale]
        assert_empty metadata[:otherMetadataLocales]
        assert_empty metadata[:resourceScopes]
        assert_equal 2, metadata[:metadataContacts].length
        assert_empty metadata[:metadataCreationDate]
        assert_empty metadata[:otherMetadataDates]
        assert_empty metadata[:metadataLinkages]
        assert_empty metadata[:metadataMaintenance]
        assert_empty metadata[:alternateMetadataReferences]
        assert_nil metadata[:metadataStatus]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataInfo_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
