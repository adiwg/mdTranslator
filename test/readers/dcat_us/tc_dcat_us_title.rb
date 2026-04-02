# MdTranslator - minitest of
# reader / dcat_us / module_title

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_title'

class TestReaderDcatUsTitle < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Title
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_title_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 'Types of Vegetables', metadata[:title]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]
   end

   def test_title_empty
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn['title'] = ''
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_nil metadata[:title]
   end

   def test_title_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('title')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_nil metadata[:title]
   end

end
