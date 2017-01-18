# MdTranslator - minitest of
# reader / mdJson / module_spatialReference

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialReference'

class TestReaderMdJsonSpatialReference < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialReferenceSystem
    aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
    @@hIn = aIn['spatialReferenceSystem'][0]

    def test_complete_referenceSystem_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'referenceSystemType', metadata[:systemType]
        refute_empty metadata[:systemIdentifier]
        assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_empty_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['referenceSystemType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:systemType]
        refute_empty metadata[:systemIdentifier]
        assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_missing_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('referenceSystemType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:systemType]
        refute_empty metadata[:systemIdentifier]
        assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_empty_system

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['referenceSystem'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'referenceSystemType', metadata[:systemType]
        assert_empty metadata[:systemIdentifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_missing_system

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('referenceSystem')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'referenceSystemType', metadata[:systemType]
        assert_empty metadata[:systemIdentifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['referenceSystemType'] = ''
        hIn['referenceSystem'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_referenceSystem_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('referenceSystemType')
        hIn.delete('referenceSystem')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_referenceSystem_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
