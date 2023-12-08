# MdTranslator - minitest of
# writers / iso19115_3 / class_miBand

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151MIBand < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_miBand_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'miBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_miBand',
                                                '//mrc:attribute[1]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_miBand_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'miBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      # empty elements
      hAttGroup[:attribute][0][:bandBoundaryDefinition] = ''
      hAttGroup[:attribute][0][:nominalSpatialResolution] = ''
      hAttGroup[:attribute][0][:transferFunctionType] = ''
      hAttGroup[:attribute][0][:transmittedPolarization] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_miBand',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hAttGroup[:attribute][0].delete(:bandBoundaryDefinition)
      hAttGroup[:attribute][0].delete(:nominalSpatialResolution)
      hAttGroup[:attribute][0].delete(:transferFunctionType)
      hAttGroup[:attribute][0].delete(:transmittedPolarization)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_miBand',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
