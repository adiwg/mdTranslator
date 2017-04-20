# MdTranslator - minitest of
# reader / mdJson / module_legalConstraint

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_legalConstraint'

class TestReaderMdJsonLegalConstraint < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint
    aIn = TestReaderMdJsonParent.getJson('legalConstraint.json')
    @@hIn = aIn['constraint'][0]

    def test_legalConstraint_schema

        hIn = @@hIn['legal']
        errors = TestReaderMdJsonParent.testSchema(hIn, 'constraint.json', :fragment=>'legalConstraint')
        assert_empty errors

    end

    def test_complete_legalConstraint

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'legal', metadata[:type]
        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        refute_empty metadata[:legalConstraint]
        assert_empty metadata[:securityConstraint]

        hLegalCon = metadata[:legalConstraint]
        assert_equal 2, hLegalCon[:useCodes].length
        assert_equal 'useConstraint0', hLegalCon[:useCodes][0]
        assert_equal 'useConstraint1', hLegalCon[:useCodes][1]
        assert_equal 2, hLegalCon[:accessCodes].length
        assert_equal 'accessConstraint0', hLegalCon[:accessCodes][0]
        assert_equal 'accessConstraint1', hLegalCon[:accessCodes][1]
        assert_equal 2, hLegalCon[:otherCons].length
        assert_equal 'otherConstraint0', hLegalCon[:otherCons][0]
        assert_equal 'otherConstraint1', hLegalCon[:otherCons][1]

        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_legalConstraint_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['legal']['useConstraint'] = []
        hIn['legal']['accessConstraint'] = []
        hIn['legal']['otherConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_legalConstraint_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['legal'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_legalConstraint

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('legal')
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
