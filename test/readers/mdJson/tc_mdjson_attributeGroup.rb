# MdTranslator - minitest of
# reader / mdJson / module_attributeGroup

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-18 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_attributeGroup'

class TestReaderMdJsonAttributeGroup < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AttributeGroup
    aIn = TestReaderMdJsonParent.getJson('attributeGroup.json')
    @@hIn = aIn['attributeGroup'][0]

    def test_complete_attributeGroup_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:attributeContentTypes].length
        assert_equal 'attributeContentType0', metadata[:attributeContentTypes][0]
        assert_equal 'attributeContentType1', metadata[:attributeContentTypes][1]
        assert_equal 2, metadata[:attributes].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['attribute'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:attributeContentTypes]
        assert_empty metadata[:attributes]

    end

    def test_attributeGroup_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('attribute')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:attributeContentTypes]
        assert_empty metadata[:attributes]

    end

    def test_attributeGroup_empty_contentType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['attributeContentType'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_contentType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('attributeContentType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
