# MdTranslator - minitest of
# reader / mdJson / module_spatialResolution

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialResolution'

class TestReaderMdJsonSpatialResolution < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialResolution
    aIn = TestReaderMdJsonParent.getJson('spatialResolution.json')
    @@hIn = aIn['spatialResolution'][0]

    def test_spatialResolution_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialResolution.json')
        assert_empty errors

    end

    def test_spatialResolution_scaleFactor

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'scaleFactor', metadata[:type]
        assert_equal 99999, metadata[:scaleFactor]
        assert_empty metadata[:measure]
        assert_nil metadata[:levelOfDetail]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialResolution_measure

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'measure'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'measure', metadata[:type]
        assert_nil metadata[:scaleFactor]
        refute_empty metadata[:measure]
        assert_nil metadata[:levelOfDetail]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end


    def test_spatialResolution_levelOfDetail

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'levelOfDetail'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'levelOfDetail', metadata[:type]
        assert_nil metadata[:scaleFactor]
        assert_empty metadata[:measure]
        assert_equal 'levelOfDetail', metadata[:levelOfDetail]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialResolution_invalid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_spatialResolution_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
