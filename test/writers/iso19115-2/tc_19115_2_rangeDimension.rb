# MdTranslator - minitest of
# writers / iso19115_2 / class_rangeDimension

# History:
#  Stan Smith 2018-04-17 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-06 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152RangeDimension < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage1 = TDClass.build_coverageDescription

   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage1

   @@mdHash = mdHash

   def test_rangeDimension_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash2(hAttGroup, 'range')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_rangeDimension',
                                                '//gmd:dimension[1]',
                                                '//gmd:dimension', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_rangeDimension_missing_seqId

      # suppress sequenceIdentifier block if no identifier
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash2(hAttGroup, 'range')
      hAttGroup[:attribute][0].delete(:sequenceIdentifier)
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_rangeDimension',
                                                '//gmd:dimension[2]',
                                                '//gmd:dimension', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_rangeDimension_missing_description

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash2(hAttGroup, 'range')
      hAttGroup[:attribute][0].delete(:attributeDescription)
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_rangeDimension',
                                                '//gmd:dimension[3]',
                                                '//gmd:dimension', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
