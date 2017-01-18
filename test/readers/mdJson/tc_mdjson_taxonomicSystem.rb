# MdTranslator - minitest of
# reader / mdJson / module_taxonomySystem

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-12-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomicSystem'

class TestReaderMdJsonTaxonomicSystem < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TaxonomicSystem
    aIn = TestReaderMdJsonParent.getJson('taxonomicSystem.json')
    @@hIn = aIn['taxonomicSystem'][0]

    def test_complete_taxonomicSystem_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_equal 'modifications', metadata[:modifications]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomicSystem_empty_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['citation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomicSystem_missing_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('citation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomicSystem_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['modifications'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_nil metadata[:modifications]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomicSystem_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('modifications')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_nil metadata[:modifications]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_taxonomicSystem_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end