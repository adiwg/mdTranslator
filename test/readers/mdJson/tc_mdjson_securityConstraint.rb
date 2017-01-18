# MdTranslator - minitest of
# reader / mdJson / module_securityConstraint

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_securityConstraint'

class TestReaderMdJsonSecurityConstraint < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint
    aIn = TestReaderMdJsonParent.getJson('securityConstraint.json')
    @@hIn = aIn['constraint'][0]

    def test_complete_securityConstraint

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'security', metadata[:type]
        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        assert_empty metadata[:legalConstraint]
        refute_empty metadata[:securityConstraint]

        hSecurityCon = metadata[:securityConstraint]
        assert_equal 'classification', hSecurityCon[:classCode]
        assert_equal 'classificationSystem', hSecurityCon[:classSystem]
        assert_equal 'userNote', hSecurityCon[:userNote]
        assert_equal 'handlingDescription', hSecurityCon[:handling]

        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_empty_classification

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['securityConstraint']['classification'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_missing_classification

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['securityConstraint'].delete('classification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_empty_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['securityConstraint']['classificationSystem'] = ''
        hIn['securityConstraint']['userNote'] = ''
        hIn['securityConstraint']['handlingDescription'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'security', metadata[:type]
        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        assert_empty metadata[:legalConstraint]
        refute_empty metadata[:securityConstraint]

        hSecurityCon = metadata[:securityConstraint]
        assert_equal 'classification', hSecurityCon[:classCode]
        assert_nil hSecurityCon[:classSystem]
        assert_nil hSecurityCon[:userNote]
        assert_nil hSecurityCon[:handling]

        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_missing_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['securityConstraint'].delete('classificationSystem')
        hIn['securityConstraint'].delete('userNote')
        hIn['securityConstraint'].delete('handlingDescription')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'security', metadata[:type]
        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        assert_empty metadata[:legalConstraint]
        refute_empty metadata[:securityConstraint]

        hSecurityCon = metadata[:securityConstraint]
        assert_equal 'classification', hSecurityCon[:classCode]
        assert_nil hSecurityCon[:classSystem]
        assert_nil hSecurityCon[:userNote]
        assert_nil hSecurityCon[:handling]

        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_securityConstraint

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('securityConstraint')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_constraint_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
