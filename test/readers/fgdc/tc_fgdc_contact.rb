# MdTranslator - minitest of
# readers / fgdc / module_contact

# History:
#   Stan Smith 2017-08-25 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_contact'

class TestReaderFgdcContact < TestReaderFGDCParent

   @@xDocPerson = TestReaderFGDCParent.get_XML('contact_person.xml')
   @@xDocOrg = TestReaderFGDCParent.get_XML('contact_organization.xml')

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Contact
   @@NameSpaceFgdc = ADIWG::Mdtranslator::Readers::Fgdc::Fgdc

   def test_contact_complete_person

      TestReaderFGDCParent.set_xDoc(@@xDocPerson)
      TestReaderFGDCParent.set_intObj
      xContact = @@xDocPerson.xpath('./metadata/idinfo/ptcontac')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hResponsibility = @@NameSpace.unpack(xContact, hResponse)

      refute_empty hResponsibility
      assert_nil hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 1, hResponsibility[:parties].length

      hParty = hResponsibility[:parties][0]
      refute_nil hParty[:contactId]
      assert_equal 0, hParty[:contactIndex]
      assert_equal 'individual', hParty[:contactType]
      assert_empty hParty[:organizationMembers]

      hContact = @@NameSpaceFgdc.get_contact_by_id(hParty[:contactId])
      refute_nil hContact
      refute hContact[:isOrganization]
      assert_equal 'my primary person', hContact[:name]
      assert_equal 'my position name', hContact[:positionName]
      assert_equal 1, hContact[:memberOfOrgs].length
      assert_equal 6, hContact[:phones].length
      assert_equal 2, hContact[:addresses].length
      assert_equal 2, hContact[:eMailList].length
      assert_equal 'name1@myorg.org', hContact[:eMailList][0]
      assert_equal 1, hContact[:hoursOfService].length
      assert_equal 'my hours of service', hContact[:hoursOfService][0]
      assert_equal 'my contact instructions', hContact[:contactInstructions]

      hPhone = hContact[:phones][0]
      assert_nil hPhone[:phoneName]
      assert_equal '907-555-1212', hPhone[:phoneNumber]
      assert_equal 1, hPhone[:phoneServiceTypes].length
      assert_equal 'voice', hPhone[:phoneServiceTypes][0]

      hAddress = hContact[:addresses][0]
      assert_equal 1, hAddress[:addressTypes].length
      assert_equal 'mailing', hAddress[:addressTypes][0]
      assert_nil hAddress[:description]
      assert_equal 2, hAddress[:deliveryPoints].length
      assert_equal 'mail address line 1', hAddress[:deliveryPoints][0]
      assert_equal 'mail city', hAddress[:city]
      assert_equal 'mail admin area', hAddress[:adminArea]
      assert_equal 'mail postal', hAddress[:postalCode]
      assert_equal 'mail country', hAddress[:country]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_complete_organization

      TestReaderFGDCParent.set_xDoc(@@xDocOrg)
      TestReaderFGDCParent.set_intObj
      xContact = @@xDocOrg.xpath('./metadata/idinfo/ptcontac')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hResponsibility = @@NameSpace.unpack(xContact, hResponse)

      refute_empty hResponsibility
      assert_nil hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 1, hResponsibility[:parties].length

      hParty = hResponsibility[:parties][0]
      refute_nil hParty[:contactId]
      assert_equal 1, hParty[:contactIndex]
      assert_equal 'organization', hParty[:contactType]
      assert_empty hParty[:organizationMembers]

      hContact = @@NameSpaceFgdc.get_contact_by_id(hParty[:contactId])
      refute_nil hContact
      assert hContact[:isOrganization]
      assert_equal 'my primary organization', hContact[:name]
      assert_nil hContact[:positionName]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end


end
