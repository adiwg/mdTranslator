# MdTranslator - minitest of
# reader / mdJson / module_georectifiedRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georectifiedRepresentation'

class TestReaderMdJsonGeorectifiedRepresentation < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeorectifiedRepresentation
    aIn = TestReaderMdJsonParent.getJson('georectified.json')
    @@hIn = aIn['georectifiedRepresentation'][0]

    def test_complete_georectifiedRepresentation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:checkPointAvailable]
        assert_equal 'checkPointDescription', metadata[:checkPointDescription]
        assert_equal 4, metadata[:cornerPoints].length
        assert_equal 2, metadata[:centerPoint].length
        assert_equal 'pointInPixel', metadata[:pointInPixel]
        assert_equal 'transformationDimensionDescription', metadata[:transformationDimensionDescription]
        assert_equal 'transformationDimensionMapping', metadata[:transformationDimensionMapping]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_empty_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['gridRepresentation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_missing_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('gridRepresentation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_empty_checkPoint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['checkPointAvailable'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:checkPointAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_missing_checkPoint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('checkPointAvailable')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:checkPointAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_empty_cornerPoint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['cornerPoints'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_missing_cornerPoint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('cornerPoints')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_invalid_cornerPoint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['cornerPoints'] = [ [0.0, 0.0] ]
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_empty_pointPxiel

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['pointInPixel'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_missing_pointPxiel

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('pointInPixel')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['checkPointDescription'] = ''
        hIn['centerPoint'] = []
        hIn['transformationDimensionDescription'] = ''
        hIn['transformationDimensionMapping'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:checkPointAvailable]
        assert_nil metadata[:checkPointDescription]
        assert_equal 4, metadata[:cornerPoints].length
        assert_empty metadata[:centerPoint]
        assert_equal 'pointInPixel', metadata[:pointInPixel]
        assert_nil metadata[:transformationDimensionDescription]
        assert_nil metadata[:transformationDimensionMapping]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georectifiedRepresentation_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('checkPointDescription')
        hIn.delete('centerPoint')
        hIn.delete('transformationDimensionDescription')
        hIn.delete('transformationDimensionMapping')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:checkPointAvailable]
        assert_nil metadata[:checkPointDescription]
        assert_equal 4, metadata[:cornerPoints].length
        assert_empty metadata[:centerPoint]
        assert_equal 'pointInPixel', metadata[:pointInPixel]
        assert_nil metadata[:transformationDimensionDescription]
        assert_nil metadata[:transformationDimensionMapping]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_georectifiedRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
