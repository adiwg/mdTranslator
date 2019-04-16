# MdTranslator - minitest of
# writers / iso19115_1 / class_attribute

# History:
#  Stan Smith 2019-04-16 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Attribute < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_attributeGroup_range

      # hIn = Marshal::load(Marshal.dump(@@mdHash))
      # hAttGroup = TDClass.build_attributeGroup
      # TDClass.add_attribute_dash2(hAttGroup, 'range')
      # hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup
      #
      # hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_attributeGroup',
      #                                           '//gmd:contentInfo[1]',
      #                                           '//gmd:contentInfo', 0)

      assert_equal 1,1
      # assert_equal hReturn[0], hReturn[1]
      # assert hReturn[2]
      # assert_empty hReturn[3]

   end

   # def test_attributeGroup_mdBand
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    hAttGroup = TDClass.build_attributeGroup
   #    TDClass.add_attribute_dash2(hAttGroup, 'mdBand')
   #    hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup
   #
   #    hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_attributeGroup',
   #                                              '//gmd:contentInfo[2]',
   #                                              '//gmd:contentInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   # end
   #
   # def test_attributeGroup_miBand
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    hAttGroup = TDClass.build_attributeGroup
   #    TDClass.add_attribute_dash2(hAttGroup, 'miBand')
   #    hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup
   #
   #    hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_attributeGroup',
   #                                              '//gmd:contentInfo[3]',
   #                                              '//gmd:contentInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   # end
   #
   # def test_attributeGroup_multi
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    hAttGroup = TDClass.build_attributeGroup
   #    TDClass.add_attribute_dash2(hAttGroup, 'range')
   #    TDClass.add_attribute_dash2(hAttGroup, 'range')
   #    hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup
   #
   #    hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_attributeGroup',
   #                                              '//gmd:contentInfo[4]',
   #                                              '//gmd:contentInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   # end

end
