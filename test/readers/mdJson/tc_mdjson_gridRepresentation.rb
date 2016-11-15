# MdTranslator - minitest of
# reader / mdJson / module_gridRepresentation

# History:
#   Stan Smith 2016-10-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_gridRepresentation'

class TestReaderMdJsonGridRepresentation < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GridRepresentation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'grid.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['gridRepresentation'][0]

    def test_complete_gridRepresentation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 9, metadata[:numberOfDimensions]
        assert_equal 2, metadata[:dimension].length
        assert_equal 'cellGeometry', metadata[:cellGeometry]
        assert metadata[:transformParamsAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_empty_numberOfDimensions

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['numberOfDimensions'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_missing_numberOfDimensions

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('numberOfDimensions')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_empty_cellGeometry

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['cellGeometry'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_missing_cellGeometry

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('cellGeometry')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['dimension'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 9, metadata[:numberOfDimensions]
        assert_empty metadata[:dimension]
        assert_equal 'cellGeometry', metadata[:cellGeometry]
        assert metadata[:transformParamsAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_gridRepresentation_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('dimension')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 9, metadata[:numberOfDimensions]
        assert_empty metadata[:dimension]
        assert_equal 'cellGeometry', metadata[:cellGeometry]
        assert metadata[:transformParamsAvailability]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_gridRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
