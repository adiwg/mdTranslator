# MdTranslator - minitest of
# reader / dcat_us / module_access_level

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_access_level'

class TestReaderDcatUsAccessLevel < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::AccessLevel
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_access_level_public
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:constraints].length
      constraint = hResourceInfo[:constraints][0]
      assert_equal 'legal', constraint[:type]
      assert_includes constraint[:legalConstraint][:accessCodes], 'unclassified'
      assert hResponse[:readerExecutionPass]
   end

   def test_access_level_restricted_public
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['accessLevel'] = 'restricted public'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      constraint = hResourceInfo[:constraints][0]
      assert_includes constraint[:legalConstraint][:accessCodes], 'sensitiveButUnclassified'
   end

   def test_access_level_non_public
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['accessLevel'] = 'non-public'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      constraint = hResourceInfo[:constraints][0]
      assert_includes constraint[:legalConstraint][:accessCodes], 'restricted'
   end

   def test_access_level_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('accessLevel')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:constraints]
   end

end
