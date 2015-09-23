# MdTranslator - minitest of
# reader / mdJson / module_dataQuality

# History:
# Stan Smith 2015-09-22 original script

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
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_dataQuality'

class TestReaderMdJsonDataQuality_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DataQuality
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'dataQuality.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party from process step and source to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]
    @@hIn['lineage']['processStep'][0]['processor'] = []
    @@hIn['lineage']['processStep'][1]['processor'] = []
    @@hIn['lineage']['source'][0]['citation']['responsibleParty'] = []
    @@hIn['lineage']['source'][0]['citation']['identifier'] = []
    @@hIn['lineage']['source'][0]['processStep'] = []

    def test_complete_dataQuality_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:dataScope], 'scope'
        refute_empty metadata[:dataLineage]
    end

    def test_empty_dataQuality_scope
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['scope'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_missing_dataQuality_scope
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['scope'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_dataQuality_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['lineage'] = {}
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:dataLineage]
    end

    def test_missing_dataQuality_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('lineage')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:dataLineage]
    end

    def test_empty_dataQuality_object
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
