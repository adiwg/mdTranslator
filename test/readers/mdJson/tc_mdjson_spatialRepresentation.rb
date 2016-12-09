# MdTranslator - minitest of
# reader / mdJson / module_spatialRepresentation

# History:
# Stan Smith 2016-10-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialRepresentation'

class TestReaderMdJsonSpatialRepresentation < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialRepresentation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'spatialRepresentation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['spatialRepresentation'][0]

    def test_spatialRepresentation_grid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'grid', metadata[:type]
        refute_empty metadata[:gridRepresentation]
        assert_empty metadata[:vectorRepresentation]
        assert_empty metadata[:georectifiedRepresentation]
        assert_empty metadata[:georeferenceableRepresentation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialRepresentation_vector

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'vector'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'vector', metadata[:type]
        assert_empty metadata[:gridRepresentation]
        refute_empty metadata[:vectorRepresentation]
        assert_empty metadata[:georectifiedRepresentation]
        assert_empty metadata[:georeferenceableRepresentation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialRepresentation_georectified

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'georectified'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'georectified', metadata[:type]
        assert_empty metadata[:gridRepresentation]
        assert_empty metadata[:vectorRepresentation]
        refute_empty metadata[:georectifiedRepresentation]
        assert_empty metadata[:georeferenceableRepresentation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialRepresentation_georeferenceable

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'georeferenceable'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'georeferenceable', metadata[:type]
        assert_empty metadata[:gridRepresentation]
        assert_empty metadata[:vectorRepresentation]
        assert_empty metadata[:georectifiedRepresentation]
        refute_empty metadata[:georeferenceableRepresentation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_spatialRepresentation_invalid

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_spatialRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
