# MdTranslator - minitest of
# reader / dcat_us / module_description

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_description'

class TestReaderDcatUsDescription < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Description
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_description_complete
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 'This dataset contains a list of vegetables, including nutrition information and seasonality.',
                   metadata[:abstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]
   end

   def test_description_empty
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:abstract]
   end

   def test_description_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:abstract]
   end

end
