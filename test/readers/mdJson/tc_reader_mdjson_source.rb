# MdTranslator - minitest of
# reader / mdJson / module_source

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-09-22 original script


require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_source'

class TestReaderMdJsonSource < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Source
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'source.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['source'][0]

    def test_complete_source_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        refute_empty metadata[:sourceCitation]
        assert_equal 2, metadata[:metadataCitation].length
        refute_empty metadata[:spatialResolution]
        refute_empty metadata[:referenceSystem]
        assert_equal 2, metadata[:sourceSteps].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_source_description_empty

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_source_description_missing

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_source_elements_empty

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['sourceCitation'] = {}
        hIn['sourceMetadata'] = []
        hIn['spatialResolution'] = {}
        hIn['referenceSystem'] = {}
        hIn['sourceStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:metadataCitation]
        assert_empty metadata[:spatialResolution]
        assert_empty metadata[:referenceSystem]
        assert_empty metadata[:sourceSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_source_elements_missing

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('sourceCitation')
        hIn.delete('sourceMetadata')
        hIn.delete('spatialResolution')
        hIn.delete('referenceSystem')
        hIn.delete('sourceStep')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:metadataCitation]
        assert_empty metadata[:spatialResolution]
        assert_empty metadata[:referenceSystem]
        assert_empty metadata[:sourceSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_source_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
