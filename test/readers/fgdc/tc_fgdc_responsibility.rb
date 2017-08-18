# MdTranslator - minitest of
# readers / fgdc / module_responsibility

# History:
#   Stan Smith 2017-09-18 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_responsibility'

class TestReaderFgdcResponsibility < TestReaderFGDCParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Responsibility

   def test_responsibility_complete

      TestReaderFGDCParent.set_intObj
      aNames = ['First Name', 'Second Name', 'And T. Last']
      hResponsibility = @@NameSpace.unpack(aNames, 'roleName', @@hResponseObj)

      refute_empty hResponsibility
      assert_equal 'roleName', hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 3, hResponsibility[:parties].length

      hParty = hResponsibility[:parties][0]
      refute_nil hParty[:contactId]
      assert_equal 0, hParty[:contactIndex]
      assert_equal 'individual', hParty[:contactType]
      assert_empty hParty[:organizationMembers]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
