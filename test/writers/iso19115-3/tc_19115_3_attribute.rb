# MdTranslator - minitest of
# writers / iso19115_3 / class_attribute

# History:
#  Stan Smith 2019-04-16 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Attribute < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_attributeGroup_rangeDimension

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attribute',
                                                '//mrc:attribute[1]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_attributeGroup_sampleDimension

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'sample')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attribute',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_attributeGroup_mdBand

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'mdBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attribute',
                                                '//mrc:attribute[3]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_attributeGroup_miBand

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'miBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attribute',
                                                '//mrc:attribute[4]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
