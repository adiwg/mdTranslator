# MdTranslator - minitest of
# reader / mdJson / module_processStep

# History:
# Stan Smith 2015-08-24 original script

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_processStep'

class TestReaderMdJsonProcessStep_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ProcessStep
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
    # remove responsible party (processor) to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]['lineage']['processStep'][0]
    @@hIn['processor'] = []

    def test_complete_processStep_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:stepId],          'stepId1'
        assert_equal metadata[:stepDescription], 'description1'
        assert_equal metadata[:stepRationale],   'rationale1'
        assert_equal metadata[:stepDateTime][:dateTime].to_s, '1111-11-11T00:00:00+00:00'
        assert_empty metadata[:stepProcessors]
    end

    def test_empty_processStep_description
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['description'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_missing_processStep_description
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('description')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_processStep_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['stepId'] = ''
        hIn['rationale'] = ''
        hIn['dateTime'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:stepId]
        assert_nil metadata[:stepRationale]
        assert_empty metadata[:stepDateTime]
    end

    def test_missing_processStep_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('stepId')
        hIn.delete('rationale')
        hIn.delete('dateTime')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:stepId]
        assert_nil metadata[:stepRationale]
        assert_empty metadata[:stepDateTime]
    end

    def test_empty_processStep_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
