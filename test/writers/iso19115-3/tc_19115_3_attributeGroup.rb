# MdTranslator - minitest of
# writers / iso19115_3 / class_attribute

# History:
#  Stan Smith 2019-04-17 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151AttributeGroup < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_attributeGroup_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup][0][:attributeContentType].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attributeGroup',
                                                '//mrc:attributeGroup[1]',
                                                '//mrc:attributeGroup', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_attributeGroup_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      TDClass.add_attribute_dash1(hAttGroup, 'sample')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attributeGroup',
                                                '//mrc:attributeGroup[2]',
                                                '//mrc:attributeGroup', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_attributeGroup_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      # empty element
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attributeGroup',
                                                '//mrc:attributeGroup[3]',
                                                '//mrc:attributeGroup', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing element
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup][0].delete(:attribute)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_attributeGroup',
                                                '//mrc:attributeGroup[3]',
                                                '//mrc:attributeGroup', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
