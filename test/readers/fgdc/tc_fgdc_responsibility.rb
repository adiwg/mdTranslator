# MdTranslator - minitest of
# readers / fgdc / module_responsibility

# History:
#   Stan Smith 2017-08-18 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_responsibility'

class TestReaderFgdcResponsibility < TestReaderFGDCParent

   @@FgdcNameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Fgdc
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Responsibility

   def test_responsibility_complete

      TestReaderFGDCParent.set_intObj
      hContact1 = {
         contactId: '24da7dd9-0af2-405b-be24-f0374634d567',
         isOrganization: false,
         name: 'First Name'
      }
      hContact2 = {
         contactId: 'ba467960-105d-4806-a503-2041663311c2',
         isOrganization: true,
         name: 'Second Name'
      }
      @@FgdcNameSpace.set_contact(hContact1)
      @@FgdcNameSpace.set_contact(hContact2)

      aContacts = ['24da7dd9-0af2-405b-be24-f0374634d567', 'ba467960-105d-4806-a503-2041663311c2']
      hResponsibility = @@NameSpace.unpack(aContacts, 'roleName', @@hResponseObj)

      refute_empty hResponsibility
      assert_equal 'roleName', hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 2, hResponsibility[:parties].length

      hParty = hResponsibility[:parties][0]
      assert_equal '24da7dd9-0af2-405b-be24-f0374634d567', hParty[:contactId]
      assert_equal 0, hParty[:contactIndex]
      assert_equal 'individual', hParty[:contactType]
      assert_empty hParty[:organizationMembers]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
