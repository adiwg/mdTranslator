# MdTranslator - minitest of
# writers / iso19115_3 / class_sampleDimension

# History:
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151SampleDimension < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_sampleDimension_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'sample')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_sampleDimension',
                                                '//mrc:attribute[1]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_sampleDimension_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'sample')
      hAttGroup[:attribute][0][:minValue] = ''
      hAttGroup[:attribute][0][:maxValue] = ''
      hAttGroup[:attribute][0][:units] = ''
      hAttGroup[:attribute][0][:scaleFactor] = ''
      hAttGroup[:attribute][0][:offset] = ''
      hAttGroup[:attribute][0][:meanValue] = ''
      hAttGroup[:attribute][0][:numberOfValues] = ''
      hAttGroup[:attribute][0][:standardDeviation] = ''
      # hAttGroup[:attribute][0][:bitsPerValue] = ''
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_sampleDimension',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'sample')
      hAttGroup[:attribute][0].delete(:minValue)
      hAttGroup[:attribute][0].delete(:maxValue)
      hAttGroup[:attribute][0].delete(:units)
      hAttGroup[:attribute][0].delete(:scaleFactor)
      hAttGroup[:attribute][0].delete(:rangeElementDescriptions)
      hAttGroup[:attribute][0].delete(:offset)
      hAttGroup[:attribute][0].delete(:meanValue)
      hAttGroup[:attribute][0].delete(:numberOfValues)
      # hAttGroup[:attribute][0].delete(:standardDeviation)
      hAttGroup[:attribute][0].delete(:bitsPerValue)
      hAttGroup[:attribute][0].delete(:rangeElementDescription)
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_sampleDimension',
                                                '//mrc:attribute[3]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
