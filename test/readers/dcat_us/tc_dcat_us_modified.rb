# MdTranslator - minitest of
# reader / dcat_us / module_modified

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_modified'

class TestReaderDcatUsModified < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Modified
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_modified_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 1, metadata[:dates].length
      assert_equal '2015-01-15', metadata[:dates][0][:date]
      assert_equal 'revision',   metadata[:dates][0][:dateType]
      assert hResponse[:readerExecutionPass]
   end

   def test_modified_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('modified')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:dates]
   end

end
