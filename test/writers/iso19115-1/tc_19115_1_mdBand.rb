# MdTranslator - minitest of
# writers / iso19115_1 / class_mdBand

# History:
#  Stan Smith 2019-05-08 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151MDBand < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_mdBand_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'mdBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_mdBand',
                                                '//mrc:attribute[1]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_mdBand_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'mdBand')

      # must keep one mdBand value to test

      # empty elements
      hAttGroup[:attribute][0][:boundMin] = ''
      hAttGroup[:attribute][0][:boundMax] = ''
      hAttGroup[:attribute][0][:boundUnits] = ''
      hAttGroup[:attribute][0][:peakResponse] = ''
      # hAttGroup[:attribute][0][:toneGradations] = ''

      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_mdBand',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hAttGroup[:attribute][0].delete(:boundMin)
      hAttGroup[:attribute][0].delete(:boundMax)
      hAttGroup[:attribute][0].delete(:boundUnits)
      # hAttGroup[:attribute][0].delete(:peakResponse)
      hAttGroup[:attribute][0][:peakResponse] = 5.0
      hAttGroup[:attribute][0].delete(:toneGradations)

      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_mdBand',
                                                '//mrc:attribute[3]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
