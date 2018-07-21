# MdTranslator - minitest of
# reader / mdJson / module_constraint

# History:
#  Stan Smith 2018-06-16 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'

class TestReaderMdJsonConstraint < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = []
   mdHash << TDClass.constraint
   mdHash << TDClass.useConstraint
   mdHash << TDClass.legalConstraint
   mdHash << TDClass.securityConstraint
   mdHash[0][:responsibleParty] << TDClass.build_responsibleParty('security', ['CID001'])

   @@mdHash = mdHash

   def test_constraint_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash[0], 'constraint.json')
      assert_empty errors

   end

   def test_complete_constraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'use', metadata[:type]
      assert_equal 2, metadata[:useLimitation].length
      assert_equal 'limitation one', metadata[:useLimitation][0]
      assert_equal 'limitation two', metadata[:useLimitation][1]
      refute_empty metadata[:scope]
      assert_equal 2, metadata[:graphic].length
      assert_equal 2, metadata[:reference].length
      refute_empty metadata[:releasability]
      assert_equal 2, metadata[:responsibleParty].length
      assert_empty metadata[:legalConstraint]
      assert_empty metadata[:securityConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_constraint_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['useLimitation'] = []
      hIn['scope'] = {}
      hIn['graphic'] = []
      hIn['reference'] = []
      hIn['releasability'] = {}
      hIn['responsibleParty'] = []
      hIn['legal'] = {}
      hIn['security'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'use', metadata[:type]
      assert_empty metadata[:useLimitation]
      assert_empty metadata[:scope]
      assert_empty metadata[:graphic]
      assert_empty metadata[:reference]
      assert_empty metadata[:releasability]
      assert_empty metadata[:responsibleParty]
      assert_empty metadata[:legalConstraint]
      assert_empty metadata[:securityConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_constraint_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('useLimitation')
      hIn.delete('scope')
      hIn.delete('graphic')
      hIn.delete('reference')
      hIn.delete('releasability')
      hIn.delete('responsibleParty')
      hIn.delete('legal')
      hIn.delete('security')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'use', metadata[:type]
      assert_empty metadata[:useLimitation]
      assert_empty metadata[:scope]
      assert_empty metadata[:graphic]
      assert_empty metadata[:reference]
      assert_empty metadata[:releasability]
      assert_empty metadata[:responsibleParty]
      assert_empty metadata[:legalConstraint]
      assert_empty metadata[:securityConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_use_constraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'use', metadata[:type]
      refute_empty metadata[:useLimitation]
      assert_empty metadata[:legalConstraint]
      assert_empty metadata[:securityConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_legal_constraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'legal', metadata[:type]
      refute_empty metadata[:legalConstraint]
      assert_empty metadata[:securityConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_legal_constraint_empty_legal

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
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

   def test_legal_constraint_missing_legal

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
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

   def test_security_constraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil 'security', metadata[:type]
      refute_empty metadata[:securityConstraint]
      assert_empty metadata[:legalConstraint]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_security_constraint_empty_security

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hIn['security'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint object is missing: CONTEXT is testing'

   end

   def test_security_constraint_missing_security

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('security')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint object is missing: CONTEXT is testing'

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
