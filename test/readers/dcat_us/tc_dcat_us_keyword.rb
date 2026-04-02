# MdTranslator - minitest of
# reader / dcat_us / module_keyword

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_keyword'

class TestReaderDcatUsKeyword < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Keyword
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_keyword_complete
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, metadata[:keywords].length
      kwGroup = metadata[:keywords][0]
      assert_equal 3, kwGroup[:keywords].length
      assert_equal 'vegetables', kwGroup[:keywords][0][:keyword]
      assert_equal 'nutrition',  kwGroup[:keywords][1][:keyword]
      assert_equal 'produce',    kwGroup[:keywords][2][:keyword]
      assert hResponse[:readerExecutionPass]
   end

   def test_keyword_empty_array
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['keyword'] = []
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty metadata[:keywords]
   end

   def test_keyword_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('keyword')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty metadata[:keywords]
   end

end
