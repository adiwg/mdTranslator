# MdTranslator - minitest of
# writers / iso19115_1 / class_dimension

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Dimension < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGrid = TDClass.build_gridRepresentation()
   hSpaceRep = TDClass.build_spatialRepresentation('grid', hGrid)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_dimension_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dimension',
                                                '//msr:axisDimensionProperties[1]',
                                                '//msr:axisDimensionProperties', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dimension_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hDimension = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension][0]
      hDimension.delete(:resolution)
      hDimension.delete(:dimensionTitle)
      hDimension.delete(:dimensionDescription)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dimension',
                                                '//mrs:axisDimensionProperties[2]',
                                                '//mrs:axisDimensionProperties', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
