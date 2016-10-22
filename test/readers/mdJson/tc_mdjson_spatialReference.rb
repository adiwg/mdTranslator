# MdTranslator - minitest of
# reader / mdJson / module_spatialReference

# History:
# Stan Smith 2016-11-12 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialReference'

class TestReaderMdJsonSpatialReference < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialReferenceSystem
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'spatialReference.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
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
