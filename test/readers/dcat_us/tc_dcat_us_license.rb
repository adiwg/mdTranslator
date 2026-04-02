# MdTranslator - minitest of
# reader / dcat_us / module_license

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_license'

class TestReaderDcatUsLicense < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::License
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_license_complete
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:constraints].length
      constraint = hResourceInfo[:constraints][0]
      assert_equal 'use', constraint[:type]
      assert_equal 1, constraint[:reference].length
      assert_equal 'http://creativecommons.org/publicdomain/zero/1.0/',
                   constraint[:reference][0][:title]
      assert hResponse[:readerExecutionPass]
   end

   def test_license_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('license')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:constraints]
   end

end
