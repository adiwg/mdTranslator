# MdTranslator - minitest of
# writers / iso19115_2 / class_mdBand

# History:
#  Stan Smith 2018-04-17 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-06 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152MDBand < TestWriter191152Parent

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
      TDClass.add_attribute_dash2(hAttGroup, 'mdBand')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_mdBand',
                                                '//gmd:dimension[1]',
                                                '//gmd:dimension', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_mdBand_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash2(hAttGroup, 'mdBand')
      hAttGroup[:attribute][0].delete(:maxValue)
      hAttGroup[:attribute][0].delete(:minValue)
      hAttGroup[:attribute][0].delete(:units)
      hAttGroup[:attribute][0].delete(:peakResponse)
      hAttGroup[:attribute][0].delete(:bitsPerValue)
      hAttGroup[:attribute][0].delete(:toneGradations)
      hAttGroup[:attribute][0].delete(:scaleFactor)

      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_mdBand',
                                                '//gmd:dimension[2]',
                                                '//gmd:dimension', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
