# MdTranslator - minitest of
# reader / mdJson / module_georeferencableRepresentation

# History:
#   Stan Smith 2016-10-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georeferencableRepresentation'

class TestReaderMdJsonGeoreferencableRepresentation < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeoreferencableRepresentation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'georeferencable.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['georeferencableRepresentation'][0]

    def test_complete_georeferencableRepresentation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailability]
        assert metadata[:orientationParameterAvailability]
        assert_equal 'orientationParameterDescription', metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_equal 2, metadata[:parameterCitation].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_empty_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['gridRepresentation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_missing_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('gridRepresentation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_empty_controlPt

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['controlPointAvailability'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:controlPointAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_missing_controlPt

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('controlPointAvailability')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:controlPointAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_empty_orientParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orientationParameterAvailability'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:orientationParameterAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_missing_orientParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orientationParameterAvailability')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute metadata[:orientationParameterAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_empty_geoParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['georeferencedParameter'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_missing_geoParam

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('georeferencedParameter')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orientationParameterDescription'] = ''
        hIn['parameterCitation'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailability]
        assert metadata[:orientationParameterAvailability]
        assert_nil metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_empty metadata[:parameterCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_georeferencableRepresentation_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orientationParameterDescription')
        hIn.delete('parameterCitation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:gridRepresentation]
        assert metadata[:controlPointAvailability]
        assert metadata[:orientationParameterAvailability]
        assert_nil metadata[:orientationParameterDescription]
        assert_equal 'georeferencedParameter', metadata[:georeferencedParameter]
        assert_empty metadata[:parameterCitation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_georeferencableRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
