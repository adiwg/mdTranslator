# MdTranslator - minitest of
# reader / mdJson / module_temporalExtent

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_temporalExtent'

class TestReaderMdJsonTemporalExtent < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TemporalExtent
    aIn = TestReaderMdJsonParent.getJson('temporalExtent.json')
    @@hIn = aIn['temporalExtent'][0]

    def test_temporal_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'temporalExtent.json')
        assert_empty errors

    end

    def test_complete_temporal_instant

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'instant', metadata[:type]
        refute_empty metadata[:timeInstant]
        assert_empty metadata[:timePeriod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_temporal_period

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'period'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'period', metadata[:type]
        assert_empty metadata[:timeInstant]
        refute_empty metadata[:timePeriod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_temporal_invalid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_temporal_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
