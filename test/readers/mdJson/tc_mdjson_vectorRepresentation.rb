# MdTranslator - minitest of
# reader / mdJson / module_vectorRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_vectorRepresentation'

class TestReaderMdJsonVectorRepresentation < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::VectorRepresentation
    aIn = TestReaderMdJsonParent.getJson('vector.json')
    @@hIn = aIn['vectorRepresentation'][0]

    def test_complete_vectorRepresentation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'topologyLevel', metadata[:topologyLevel]
        assert_equal 2, metadata[:vectorObject].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_vectorRepresentation_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['topologyLevel'] = ''
        hIn['vectorObject'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:topologyLevel]
        assert_empty metadata[:vectorObject]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_vectorRepresentation_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('topologyLevel')
        hIn.delete('vectorObject')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:topologyLevel]
        assert_empty metadata[:vectorObject]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_vectorRepresentation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
