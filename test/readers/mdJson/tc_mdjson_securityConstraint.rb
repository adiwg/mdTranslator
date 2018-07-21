# MdTranslator - minitest of
# reader / mdJson / module_securityConstraint

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_securityConstraint'

class TestReaderMdJsonSecurityConstraint < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.securityConstraint

   @@mdHash = mdHash

   def test_secCon_schema

      hIn = @@mdHash[:security]
      errors = TestReaderMdJsonParent.testSchema(hIn, 'constraint.json', :fragment => 'securityConstraint')
      assert_empty errors

   end

   def test_complete_secCon

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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
      assert_equal 'classification system', hSecurityCon[:classSystem]
      assert_equal 'user note', hSecurityCon[:userNote]
      assert_equal 'handling instructions', hSecurityCon[:handling]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_secCon_empty_classification

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['security']['classification'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint classification is missing: CONTEXT is testing'

   end

   def test_secCon_missing_classification

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['security'].delete('classification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint classification is missing: CONTEXT is testing'

   end

   def test_empty_securityConstraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
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

   def test_missing_securityConstraint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
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

   def test_secCon_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['security']['classificationSystem'] = ''
      hIn['security']['userNote'] = ''
      hIn['security']['handlingDescription'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

   def test_secCon_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['security'].delete('classificationSystem')
      hIn['security'].delete('userNote')
      hIn['security'].delete('handlingDescription')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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
