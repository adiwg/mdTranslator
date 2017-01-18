# MdTranslator - minitest of
# reader / mdJson / module_source

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-09-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_source'

class TestReaderMdJsonSource < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Source
    aIn = TestReaderMdJsonParent.getJson('source.json')
    @@hIn = aIn['source'][0]

    def test_complete_source_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        refute_empty metadata[:sourceCitation]
        assert_equal 2, metadata[:metadataCitation].length
        assert_equal 9, metadata[:scaleDenominator]
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
        hIn['scaleDenominator'] = ''
        hIn['sourceReferenceSystem'] = {}
        hIn['sourceStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:metadataCitation]
        assert_nil metadata[:scaleDenominator]
        assert_empty metadata[:referenceSystem]
        assert_empty metadata[:sourceSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_source_elements_missing

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('sourceCitation')
        hIn.delete('sourceMetadata')
        hIn.delete('scaleDenominator')
        hIn.delete('sourceReferenceSystem')
        hIn.delete('sourceStep')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_empty metadata[:sourceCitation]
        assert_empty metadata[:metadataCitation]
        assert_nil metadata[:scaleDenominator]
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
