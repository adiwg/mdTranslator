# MdTranslator - minitest of
# reader / mdJson / module_legalConstraint

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_legalConstraint'

class TestReaderMdJsonLegalConstraint < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.legalConstraint

   @@mdHash = mdHash

   def test_legalConstraint_schema

      hIn = @@mdHash[:legal]
      errors = TestReaderMdJsonParent.testSchema(hIn, 'constraint.json', :fragment => 'legalConstraint')
      assert_empty errors

   end

   def test_complete_legalConstraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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
      assert_equal 'use constraint one', hLegalCon[:useCodes][0]
      assert_equal 'use constraint two', hLegalCon[:useCodes][1]
      assert_equal 2, hLegalCon[:accessCodes].length
      assert_equal 'access constraint one', hLegalCon[:accessCodes][0]
      assert_equal 'access constraint two', hLegalCon[:accessCodes][1]
      assert_equal 2, hLegalCon[:otherCons].length
      assert_equal 'other constraint one', hLegalCon[:otherCons][0]
      assert_equal 'other constraint two', hLegalCon[:otherCons][1]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_legalConstraint_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['legal']['useConstraint'] = []
      hIn['legal']['accessConstraint'] = []
      hIn['legal']['otherConstraint'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: legal constraint was not defined: CONTEXT is testing'

   end

   def test_missing_legalConstraint_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['legal']['nonElement'] = ''
      hIn['legal'].delete('useConstraint')
      hIn['legal'].delete('accessConstraint')
      hIn['legal'].delete('otherConstraint')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: legal constraint was not defined: CONTEXT is testing'

   end

   def test_missing_legalConstraint_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['legal'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: legal constraint object is missing: CONTEXT is testing'

   end

   def test_missing_legalConstraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('legal')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: legal constraint object is missing: CONTEXT is testing'

   end

   def test_empty_constraint_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: constraint object is empty: CONTEXT is testing'

   end

end
