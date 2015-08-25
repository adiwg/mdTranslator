# MdTranslator - minitest of
# reader / mdJson / module_distributionOrder

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_distributionOrder'

class TestReaderMdJsonDistributionOrder_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DistributionOrder
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
    @@hIn = aIn[0]['distributionOrderProcess'][0]

    def test_complete_distributionOrder_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:fees],              'fees1'
        assert_equal metadata[:plannedDateTime][:dateTime].to_s, '1111-11-11T00:00:00+00:00'
        assert_equal metadata[:orderInstructions], 'orderingInstructions1'
        assert_equal metadata[:turnaround],        'turnaround1'
    end

    def test_empty_distributionOrder_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['fees'] = ''
        hIn['plannedAvailabilityDateTime'] = ''
        hIn['orderingInstructions'] = ''
        hIn['turnaround'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:fees]
        assert_empty metadata[:plannedDateTime]
        assert_nil metadata[:orderInstructions]
        assert_nil metadata[:turnaround]
    end

    def test_missing_distributionOrder_elements_a
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('fees')
        hIn.delete('plannedAvailabilityDateTime')
        hIn.delete('orderingInstructions')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:fees]
        assert_empty metadata[:plannedDateTime]
        assert_nil metadata[:orderInstructions]
    end

    def test_missing_distributionOrder_elements_b
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('turnaround')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:turnaround]
    end

    def test_empty_distributionOrder_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
