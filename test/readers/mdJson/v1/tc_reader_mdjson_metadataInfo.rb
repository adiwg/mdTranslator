# MdTranslator - minitest of
# reader / mdJson / module_metadataInfo

# History:
# Stan Smith 2015-089-22 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.1.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_metadataInfo'

class TestReaderMdJsonMetadataInfo_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataInfo
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'metadataInfo.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party (processor) to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]
    @@hIn['parentMetadata']['responsibleParty'] = []
    @@hIn['parentMetadata']['identifier'] = []
    @@hIn['metadataContact'] = []
    @@hIn['metadataMaintenance']['maintenanceContact'] = []

    # need to place in metadataInfo object wrapper because full metadata hash is
    # passed to module_metadataInfo.  This is done because the taxonomy section
    # in resourceInfo needs to be tested before loading extensionInformation
    @@hIn = {'metadataInfo' => @@hIn}

    def test_complete_metadataInfo_object
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        # metadataIdentifier in resourceId
        assert_equal metadata[:metadataId][:identifier],     'identifier1'
        assert_equal metadata[:metadataId][:identifierType], 'type1'
        # parentMetadata in citation
        refute_empty metadata[:parentMetadata]
        # metadataCustodians - not tested
        assert_empty metadata[:metadataCustodians]
        # metadataInfo fields
        refute_empty metadata[:metadataCreateDate]
        refute_empty metadata[:metadataUpdateDate]
        assert_equal metadata[:metadataCharacterSet],        'metadataCharacterSet'
        assert_empty metadata[:metadataLocales]
        assert_equal metadata[:metadataURI],                 'http://thisisanexample.com'
        assert_equal metadata[:metadataStatus],              'metadataStatus'
        # metadataMaintenance
        refute_empty metadata[:maintInfo]
        # extensions - empty since taxonomy not passed in
        assert_empty metadata[:extensions]
    end

    def test_empty_metadataInfo_elements
        hIn = @@hIn.clone
        hIn['metadataInfo']['metadataIdentifier'] = {}
        hIn['metadataInfo']['parentMetadata'] = {}
        hIn['metadataInfo']['metadataContact'] = []
        hIn['metadataInfo']['metadataCreationDate'] = ''
        hIn['metadataInfo']['metadataLastUpdate'] = ''
        hIn['metadataInfo']['metadataCharacterSet'] = ''
        hIn['metadataInfo']['metadataLocales'] = []
        hIn['metadataInfo']['metadataUri'] = ''
        hIn['metadataInfo']['metadataStatus'] = ''
        hIn['metadataInfo']['metadataMaintenance'] = {}

        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:metadataId]
        assert_empty metadata[:parentMetadata]
        assert_empty metadata[:metadataCustodians]
        assert_empty metadata[:metadataCreateDate]
        assert_empty metadata[:metadataUpdateDate]
        assert_equal metadata[:metadataCharacterSet], 'utf8'
        assert_empty metadata[:metadataLocales]
        assert_nil metadata[:metadataURI]
        assert_nil metadata[:metadataStatus]
        assert_empty metadata[:maintInfo]
        assert_empty metadata[:extensions]
    end

    def test_missing_metadataInfo_elements
        hIn = @@hIn.clone
        hIn['metadataInfo'] = {}

        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:metadataId]
        assert_empty metadata[:parentMetadata]
        assert_empty metadata[:metadataCustodians]
        assert_empty metadata[:metadataCreateDate]
        assert_empty metadata[:metadataUpdateDate]
        assert_nil metadata[:metadataCharacterSet]
        assert_empty metadata[:metadataLocales]
        assert_nil metadata[:metadataURI]
        assert_nil metadata[:metadataStatus]
        assert_empty metadata[:maintInfo]
        assert_empty metadata[:extensions]
    end

    def test_empty_metadataInfo_object
        hIn = {}
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
