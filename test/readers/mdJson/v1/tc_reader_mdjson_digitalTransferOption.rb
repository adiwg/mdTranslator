# MdTranslator - minitest of
# reader / mdJson / module_digitalTransferOption

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_digitalTransferOption'

class TestReaderMdJsonDigitalTransOption_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DigitalTransOption
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'distributor.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['distributorTransferOptions'][0]

    def test_complete_digitalTransferOption_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:online].length, 1
        refute_empty metadata[:online]
        refute_empty metadata[:offline]
    end

    def test_empty_digitalTransferOption_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['online'] = []
        hIn['offline'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:online]
        assert_empty metadata[:offline]
    end

    def test_missing_digitalTransferOption_elements_a
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('online')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:online]
    end

    def test_missing_digitalTransferOption_elements_b
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('offline')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:offline]
    end

    def test_empty_digitalTransferOption_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
