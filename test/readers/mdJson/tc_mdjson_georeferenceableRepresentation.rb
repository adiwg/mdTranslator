# MdTranslator - minitest of
# reader / mdJson / module_georeferencableRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georeferenceableRepresentation'

class TestReaderMdJsonGeoreferenceableRepresentation < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeoreferenceableRepresentation
    aIn = TestReaderMdJsonParent.getJson('georeferenceable.json')
    @@hIn = aIn['georeferenceableRepresentation'][0]

    def test_complete_georeferenceableRepresentation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailable]
        assert metadata[:orientationParameterAvailable]
        assert_equal 'orientationParameterDescription', metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_equal 2, metadata[:parameterCitation].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_empty_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['gridRepresentation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_missing_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('gridRepresentation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_empty_controlPt

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['controlPointAvailable'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:controlPointAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_missing_controlPt

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('controlPointAvailable')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:controlPointAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_empty_orientParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orientationParameterAvailable'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:orientationParameterAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_missing_orientParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orientationParameterAvailable')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:orientationParameterAvailable]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_empty_geoParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['georeferencedParameter'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_missing_geoParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('georeferencedParameter')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orientationParameterDescription'] = ''
        hIn['parameterCitation'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailable]
        assert metadata[:orientationParameterAvailable]
        assert_nil metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_empty metadata[:parameterCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferenceableRepresentation_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orientationParameterDescription')
        hIn.delete('parameterCitation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailable]
        assert metadata[:orientationParameterAvailable]
        assert_nil metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_empty metadata[:parameterCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_georeferenceableRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
