# MdTranslator - minitest of
# reader / dcat_us / module_bureau_code

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_bureau_code'

class TestReaderDcatUsBureauCode < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::BureauCode
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_bureau_code_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation
      aContacts = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      # Two bureau codes in fixture -> two contacts
      assert_equal 2, aContacts.length

      aContacts.each do |contact|
         assert contact[:isOrganization]
         ext_id = contact[:externalIdentifier].find { |id| id[:namespace] == 'bureauCode' }
         refute_nil ext_id
      end

      identifiers = aContacts.map { |c| c[:externalIdentifier].find { |id| id[:namespace] == 'bureauCode' }[:identifier] }
      assert_includes identifiers, '010:86'
      assert_includes identifiers, '010:04'

      # Two responsible parties added to citation
      bureau_parties = hCitation[:responsibleParties].select { |p| p[:roleName] == 'bureau' }
      assert_equal 2, bureau_parties.length

      assert hResponse[:readerExecutionPass]
   end

   def test_bureau_code_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('bureauCode')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation
      aContacts = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      assert_empty aContacts
   end

end
