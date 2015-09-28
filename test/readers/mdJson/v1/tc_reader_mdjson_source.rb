# MdTranslator - minitest of
# reader / mdJson / module_source

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_source'

class TestReaderMdJsonSource_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Source
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
    @@hIn = aIn[0]['lineage']['source'][0]
    @@hIn['citation']['responsibleParty'] = []
    @@hIn['citation']['identifier'] = []
    @@hIn['processStep'][0]['processor'] = []
    @@hIn['processStep'][1]['processor'] = []

    def test_complete_source_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:sourceDescription], 'description1'
        refute_empty metadata[:sourceCitation]
        assert_equal metadata[:sourceSteps].length, 2
    end

    def test_empty_source_elements_a
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['citation'] = {}
        hIn['processStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:sourceDescription], 'description1'
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:sourceSteps]
    end

    def test_empty_source_elements_b
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:sourceDescription]
        refute_empty metadata[:sourceCitation]
        refute_empty metadata[:sourceSteps]
    end

    def test_missing_source_elements_a
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('citation')
        hIn.delete('processStep')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:sourceDescription], 'description1'
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:sourceSteps]
    end

    def test_missing_source_elements_b
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:sourceDescription]
        refute_empty metadata[:sourceCitation]
        refute_empty metadata[:sourceSteps]
    end

    def test_empty_source_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
