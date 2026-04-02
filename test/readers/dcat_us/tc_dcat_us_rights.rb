# MdTranslator - minitest of
# reader / dcat_us / module_rights

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_rights'

class TestReaderDcatUsRights < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Rights
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_rights_present
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['rights'] = 'Restricted to authorized personnel only.'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:constraints].length
      constraint = hResourceInfo[:constraints][0]
      assert_equal 'use', constraint[:type]
      assert_equal 'Restricted to authorized personnel only.',
                   constraint[:releasability][:statement]
      assert hResponse[:readerExecutionPass]
   end

   def test_rights_null
      # Fixture has "rights": null
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:constraints]
   end

   def test_rights_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('rights')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:constraints]
   end

end
