# MdTranslator - minitest of
# readers / fgdc / module_security

# History:
#   Stan Smith 2017-08-25 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcSecurity < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('security.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Security

   def test_security_complete

      xIn = @@xDoc.xpath('./metadata/idinfo/secinfo')
      hConstraint = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hConstraint
      assert_equal 'security', hConstraint[:type]
      refute_empty hConstraint[:securityConstraint]

      hSecurity = hConstraint[:securityConstraint]
      assert_equal 'secret', hSecurity[:classCode]
      assert_nil hSecurity[:userNote]
      assert_equal 'my security system name', hSecurity[:classSystem]
      assert_equal 'my security handling instructions', hSecurity[:handling]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
