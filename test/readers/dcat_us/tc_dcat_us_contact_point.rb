# MdTranslator - minitest of
# reader / dcat_us / module_contact_point

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_contact_point'

class TestReaderDcatUsContactPoint < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::ContactPoint
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_contact_point_complete
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo
      aContacts     = []

      @@NameSpace.unpack(hIn, hResourceInfo, aContacts, hResponse)

      assert_equal 1, aContacts.length
      contact = aContacts[0]
      assert_equal 'Jane Doe', contact[:name]
      refute contact[:isOrganization]
      assert_equal 1, contact[:eMailList].length
      assert_equal 'jane.doe@agency.gov', contact[:eMailList][0]

      assert_equal 1, hResourceInfo[:pointOfContacts].length
      poc = hResourceInfo[:pointOfContacts][0]
      assert_equal 'pointOfContact', poc[:roleName]
      assert_equal contact[:contactId], poc[:parties][0][:contactId]

      assert hResponse[:readerExecutionPass]
   end

   def test_contact_point_strips_mailto
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['contactPoint']['hasEmail'] = 'mailto:test@example.com'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo
      aContacts     = []

      @@NameSpace.unpack(hIn, hResourceInfo, aContacts, hResponse)

      assert_equal 'test@example.com', aContacts[0][:eMailList][0]
   end

   def test_contact_point_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('contactPoint')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo
      aContacts     = []

      @@NameSpace.unpack(hIn, hResourceInfo, aContacts, hResponse)

      assert_empty aContacts
      assert_empty hResourceInfo[:pointOfContacts]
   end

end
