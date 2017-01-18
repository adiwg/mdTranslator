# MdTranslator - minitest of
# reader / mdJson / module_processStep

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2015-08-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_processStep'

class TestReaderMdJsonProcessStep < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ProcessStep
    aIn = TestReaderMdJsonParent.getJson('processStep.json')
    @@hIn = aIn['processStep'][0]

    def test_complete_processStep_object

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'stepId', metadata[:stepId]
        assert_equal 'description', metadata[:description]
        assert_equal 'rationale', metadata[:rationale]
        refute_empty metadata[:timePeriod]
        assert_equal 2, metadata[:processors].length
        assert_equal 2, metadata[:references].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_processStep_description

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_processStep_description

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_processStep_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['stepId'] = ''
        hIn['rationale'] = ''
        hIn['timePeriod'] = {}
        hIn['processor'] = []
        hIn['reference'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:stepId]
        assert_nil metadata[:rationale]
        assert_empty metadata[:timePeriod]
        assert_empty metadata[:processors]
        assert_empty metadata[:references]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_processStep_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('stepId')
        hIn.delete('rationale')
        hIn.delete('timePeriod')
        hIn.delete('processor')
        hIn.delete('reference')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:stepId]
        assert_nil metadata[:rationale]
        assert_empty metadata[:timePeriod]
        assert_empty metadata[:processors]
        assert_empty metadata[:references]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_processStep_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
