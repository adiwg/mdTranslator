# MdTranslator - minitest of
# reader / mdJson / module_measure

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-16 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_measure'

class TestReaderMdJsonMeasure < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Measure
    aIn = TestReaderMdJsonParent.getJson('measure.json')
    @@hIn = aIn['measure'][0]

    def test_complete_measure_object_distance

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'distance', metadata[:type]
        assert_equal 99.9, metadata[:value]
        assert_equal 'unitOfMeasure', metadata[:unitOfMeasure]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_measure_object_length

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'length'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'length', metadata[:type]
        assert_equal 99.9, metadata[:value]
        assert_equal 'unitOfMeasure', metadata[:unitOfMeasure]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_measure_object_vertical

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'vertical'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'vertical', metadata[:type]
        assert_equal 99.9, metadata[:value]
        assert_equal 'unitOfMeasure', metadata[:unitOfMeasure]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_measure_object_angle

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'angle'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'angle', metadata[:type]
        assert_equal 99.9, metadata[:value]
        assert_equal 'unitOfMeasure', metadata[:unitOfMeasure]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_measure_object_invalid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_empty_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_empty_value

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['value'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_empty_unitOfMeasure

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['unitOfMeasure'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_missing_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('type')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_missing_value

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('value')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_measure_missing_unitOfMeasure

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('unitOfMeasure')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_measure_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
