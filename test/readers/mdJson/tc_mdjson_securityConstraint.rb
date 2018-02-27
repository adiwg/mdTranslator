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

   def test_secCon_schema

      hIn = @@hIn['security']
      errors = TestReaderMdJsonParent.testSchema(hIn, 'constraint.json', :fragment => 'securityConstraint')
      assert_empty errors

   end

   def test_complete_secCon

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

   def test_secCon_empty_classification

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['security']['classification'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint classification is missing'

   end

   def test_secCon_missing_classification

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['security'].delete('classification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint classification is missing'

   end

   def test_empty_securityConstraint

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('security')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint object is missing'

   end

   def test_missing_securityConstraint

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('security')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: security constraint object is missing'

   end

   def test_secCon_empty_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['security']['classificationSystem'] = ''
      hIn['security']['userNote'] = ''
      hIn['security']['handlingDescription'] = ''
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

   def test_secCon_missing_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['security'].delete('classificationSystem')
      hIn['security'].delete('userNote')
      hIn['security'].delete('handlingDescription')
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

   def test_empty_constraint_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: constraint object is empty'

   end

end
