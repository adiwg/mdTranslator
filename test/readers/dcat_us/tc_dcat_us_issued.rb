# MdTranslator - minitest of
# reader / dcat_us / module_issued

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_issued'

class TestReaderDcatUsIssued < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Issued
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_issued_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 1, hCitation[:dates].length
      assert_equal '2001-01-15', hCitation[:dates][0][:date]
      assert_equal 'creation',   hCitation[:dates][0][:dateType]
      assert hResponse[:readerExecutionPass]
   end

   def test_issued_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('issued')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty hCitation[:dates]
   end

end
