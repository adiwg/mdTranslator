# MdTranslator - minitest of
# reader / mdJson / module_resourceUsage

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-11 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceUsage'

class TestReaderMdJsonResourceUsage < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceUsage
    aIn = TestReaderMdJsonParent.getJson('usage.json')
    @@hIn = aIn['resourceUsage'][0]

    def test_resourceUsage_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'usage.json')
        assert_empty errors

    end

    def test_complete_resourceUsage_object

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_equal 2, metadata[:temporalExtents].length
        assert_equal 'userDeterminedLimitation', metadata[:userLimitation]
        assert_equal 2, metadata[:limitationResponses].length
        assert_equal 'limitationResponse0', metadata[:limitationResponses][0]
        assert_equal 'limitationResponse1', metadata[:limitationResponses][1]
        refute_empty metadata[:identifiedIssue]
        assert_equal 2, metadata[:additionalDocumentation].length
        assert_equal 2, metadata[:userContacts].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_empty_specificUsage

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['specificUsage'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_missing_specificUsage

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('specificUsage')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_empty_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['temporalExtent'] = []
        hIn['userDeterminedLimitation'] = ''
        hIn['limitationResponse'] = []
        hIn['documentedIssue'] = {}
        hIn['additionalDocumentation'] = []
        hIn['userContactInfo'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_empty metadata[:temporalExtents]
        assert_nil metadata[:userLimitation]
        assert_empty metadata[:limitationResponses]
        assert_empty metadata[:identifiedIssue]
        assert_empty metadata[:additionalDocumentation]
        assert_empty metadata[:userContacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_missing_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('temporalExtent')
        hIn.delete('userDeterminedLimitation')
        hIn.delete('limitationResponse')
        hIn.delete('documentedIssue')
        hIn.delete('additionalDocumentation')
        hIn.delete('userContactInfo')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_empty metadata[:temporalExtents]
        assert_nil metadata[:userLimitation]
        assert_empty metadata[:limitationResponses]
        assert_empty metadata[:identifiedIssue]
        assert_empty metadata[:additionalDocumentation]
        assert_empty metadata[:userContacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceUsage_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
