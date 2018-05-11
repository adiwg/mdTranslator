# MdTranslator - minitest of
# writers / iso19115_2 / class_coverageDescription

# History:
#  Stan Smith 2018-04-12 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-20 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152CoverageDescription < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_coverageInfo_base

      hReturn = TestWriter191152Parent.run_test(@@mdHash, '19115_2_coverageDescription', '//gmd:contentInfo[1]',
                                                '//gmd:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: coverage content type is missing'

   end

   def test_coverageInfo_image

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_imageDescription(hIn[:metadata][:resourceInfo][:coverageDescription][0])

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[2]',
                                                '//gmd:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_attributeGroup

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[3]',
                                                '//gmd:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_multiple_attributeGroup

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup1 = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[4]',
                                                '//gmd:contentInfo', 0)
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]


      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[5]',
                                                '//gmd:contentInfo', 1)
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_coverageInfo_attributeGroup_image_mix

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup1 = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup1
      TDClass.add_imageDescription(hIn[:metadata][:resourceInfo][:coverageDescription][0])

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[6]',
                                                '//gmd:contentInfo', 0)
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_coverageDescription', '//gmd:contentInfo[7]',
                                                '//gmd:contentInfo', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
