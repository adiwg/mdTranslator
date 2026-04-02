# MdTranslator - minitest of
# reader / dcat_us / module_program_code

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_program_code'

class TestReaderDcatUsProgramCode < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::ProgramCode
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_program_code_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation
      aContacts = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      assert_equal 1, aContacts.length
      contact = aContacts[0]
      assert contact[:isOrganization]
      ext_id = contact[:externalIdentifier].find { |id| id[:namespace] == 'programCode' }
      refute_nil ext_id
      assert_equal '015:001', ext_id[:identifier]

      program_parties = hCitation[:responsibleParties].select { |p| p[:roleName] == 'program' }
      assert_equal 1, program_parties.length

      assert hResponse[:readerExecutionPass]
   end

   def test_program_code_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('programCode')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation
      aContacts = []

      @@NameSpace.unpack(hIn, hCitation, aContacts, hResponse)

      assert_empty aContacts
   end

end
