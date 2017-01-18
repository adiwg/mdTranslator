# MdTranslator - minitest of
# reader / mdJson / module_releasability

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_releasability'

class TestReaderMdJsonReleasability < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Releasability
    aIn = TestReaderMdJsonParent.getJson('releasability.json')
    @@hIn = aIn['releasability'][0]

    def test_complete_releasability_object

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_equal 2, metadata[:disseminationConstraint].length
        assert_equal 'disseminationConstraint0', metadata[:disseminationConstraint][0]
        assert_equal 'disseminationConstraint1', metadata[:disseminationConstraint][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_releasability_empty_addressee_statement

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['addressee'] = []
        hIn['statement'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_releasability_missing_addressee_statement

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('addressee')
        hIn.delete('statement')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_releasability_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['disseminationConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:disseminationConstraint]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_releasability_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['disseminationConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:disseminationConstraint]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_releasability_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
