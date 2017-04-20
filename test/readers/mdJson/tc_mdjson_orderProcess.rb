# MdTranslator - minitest of
# reader / mdJson / module_orderProcess

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_orderProcess'

class TestReaderMdJsonOrderProcess < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OrderProcess
    aIn = TestReaderMdJsonParent.getJson('orderProcess.json')
    @@hIn = aIn['orderProcess'][0]

    def test_orderProcess_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'orderProcess.json')
        assert_empty errors

    end

    def test_complete_orderProcess_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal '0.00USD', metadata[:fees]
        assert_kind_of DateTime, metadata[:plannedAvailability][:dateTime]
        assert_equal 'YMDhms', metadata[:plannedAvailability][:dateResolution]
        assert_equal 'orderingInstructions', metadata[:orderingInstructions]
        assert_equal 'turnaround', metadata[:turnaround]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_orderProcess_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['fees'] = ''
        hIn['plannedAvailability'] = {}
        hIn['orderingInstructions'] = ''
        hIn['turnaround'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:fees]
        assert_empty metadata[:plannedAvailability]
        assert_nil metadata[:orderingInstructions]
        assert_nil metadata[:turnaround]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_orderProcess_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('fees')
        hIn.delete('plannedAvailability')
        hIn.delete('orderingInstructions')
        hIn.delete('turnaround')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:fees]
        assert_empty metadata[:plannedAvailability]
        assert_nil metadata[:orderingInstructions]
        assert_nil metadata[:turnaround]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_orderProcess_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
