# MdTranslator - minitest of
# reader / dcat_us / module_publisher

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_publisher'

class TestReaderDcatUsPublisher < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Publisher
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_publisher_complete
      hIn        = Marshal.load(Marshal.dump(@@hIn))
      hResponse  = Marshal.load(Marshal.dump(@@responseObj))
      hCitation  = @@intMetadataClass.newCitation
      aContacts  = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      # Two contacts: publisher org + parent org
      assert_equal 2, aContacts.length

      publisher_contact = aContacts[0]
      parent_contact    = aContacts[1]

      assert publisher_contact[:isOrganization]
      assert_equal 'Widget Services', publisher_contact[:name]
      assert_includes publisher_contact[:memberOfOrgs], parent_contact[:contactId]

      assert parent_contact[:isOrganization]
      assert_equal 'General Services Administration', parent_contact[:name]

      # One responsible party with role 'publisher'
      assert_equal 1, hCitation[:responsibleParties].length
      party = hCitation[:responsibleParties][0]
      assert_equal 'publisher', party[:roleName]
      assert_equal publisher_contact[:contactId], party[:parties][0][:contactId]

      assert hResponse[:readerExecutionPass]
   end

   def test_publisher_no_sub_org
      hIn        = Marshal.load(Marshal.dump(@@hIn))
      hIn['publisher'] = { 'name' => 'Simple Agency' }
      hResponse  = Marshal.load(Marshal.dump(@@responseObj))
      hCitation  = @@intMetadataClass.newCitation
      aContacts  = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      assert_equal 1, aContacts.length
      assert_equal 'Simple Agency', aContacts[0][:name]
      assert_empty aContacts[0][:memberOfOrgs]
   end

   def test_publisher_missing
      hIn        = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('publisher')
      hResponse  = Marshal.load(Marshal.dump(@@responseObj))
      hCitation  = @@intMetadataClass.newCitation
      aContacts  = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      assert_empty aContacts
      assert_empty hCitation[:responsibleParties]
   end

end
