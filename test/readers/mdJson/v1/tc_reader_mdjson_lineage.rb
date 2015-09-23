# MdTranslator - minitest of
# reader / mdJson / module_lineage

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_lineage'

class TestReaderMdJsonLineage_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Lineage
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
    @@hIn = aIn[0]['lineage']
    @@hIn['processStep'][0]['processor'] = []
    @@hIn['processStep'][1]['processor'] = []
    @@hIn['source'][0]['citation'] = {}
    @@hIn['source'][0]['processStep'] = []

    def test_complete_lineage_object
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:statement], 'statement'
        assert_equal metadata[:processSteps].length, 2
        assert_equal metadata[:dataSources].length, 1
    end

    def test_empty_lineage_elements_a
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['processStep'] = []
        hIn['source'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:statement], 'statement'
        assert_empty metadata[:processSteps]
        assert_empty metadata[:dataSources]
    end

    def test_empty_lineage_elements_b
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['statement'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:statement]
        refute_empty metadata[:processSteps]
        refute_empty metadata[:dataSources]
    end

    def test_missing_lineage_elements_a
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('processStep')
        hIn.delete('source')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:statement], 'statement'
        assert_empty metadata[:processSteps]
        assert_empty metadata[:dataSources]
    end

    def test_missing_lineage_elements_b
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('statement')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:statement]
        refute_empty metadata[:processSteps]
        refute_empty metadata[:dataSources]
    end

    def test_empty_lineage_object
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
