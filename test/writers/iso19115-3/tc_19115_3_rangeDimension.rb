# MdTranslator - minitest of
# writers / iso19115_3 / class_rangeDimension

# History:
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151RangeDimension < TestWriter191151Parent

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
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_rangeDimension',
                                                '//mrc:attribute[1]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_rangeDimension_seqId

      # sequence identifier is sequenceIdentifier + sequenceIdentifierType
      # missing sequenceIdentifier (tag is suppressed)
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hAttGroup[:attribute][0].delete(:sequenceIdentifier)
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_rangeDimension',
                                                '//mrc:attribute[2]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # identifierType is required by reader if identifier present
      # missing sequenceIdentifierType (mdJSON reader throws exception)

   end

   def test_rangeDimension_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hAttGroup[:attribute][0][:sequenceIdentifier] = ''
      hAttGroup[:attribute][0][:attributeDescription] = ''
      hAttGroup[:attribute][0][:attributeIdentifier] = []
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_rangeDimension',
                                                '//mrc:attribute[3]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAttGroup = TDClass.build_attributeGroup
      TDClass.add_attribute_dash1(hAttGroup, 'range')
      hAttGroup[:attribute][0].delete(:sequenceIdentifier)
      hAttGroup[:attribute][0].delete(:attributeDescription)
      hAttGroup[:attribute][0].delete(:attributeIdentifier)
      hIn[:metadata][:resourceInfo][:coverageDescription][0][:attributeGroup] << hAttGroup

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_rangeDimension',
                                                '//mrc:attribute[3]',
                                                '//mrc:attribute', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
