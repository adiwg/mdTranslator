# MdTranslator - minitest of
# writers / iso19115_3 / class_coverageDescription

# History:
#  Stan Smith 2019-04-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151CoverageDescription < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_coverageDescription_minimum

      hReturn = TestWriter191151Parent.run_test(@@mdHash, '19115_3_coverageDescription', '//mdb:contentInfo[1]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]
   end

   def test_coverageInfo_image

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_imageDescription(hIn[:metadata][:resourceInfo][:coverageDescription][0])

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_coverageDescription', '//mdb:contentInfo[2]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_attributeGroup

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_coverageDescription', '//mdb:contentInfo[3]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_attributeGroup_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup1 = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_coverageDescription', '//mdb:contentInfo[4]',
                                                '//mdb:contentInfo', 0)
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_attributeGroup_image_mix

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup1 = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1
      TDClass.add_imageDescription(hIn[:metadata][:resourceInfo][:coverageDescription][0])

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_coverageDescription', '//mdb:contentInfo[5]',
                                                '//mdb:contentInfo', 0)
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
