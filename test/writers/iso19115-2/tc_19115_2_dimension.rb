# MdTranslator - minitest of
# writers / iso19115_2 / class_dimension

# History:
#  Stan Smith 2018-04-19 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-23 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Dimension < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dimension',
                                                '//gmd:axisDimensionProperties[1]',
                                                '//gmd:axisDimensionProperties', 0)

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dimension',
                                                '//gmd:axisDimensionProperties[2]',
                                                '//gmd:axisDimensionProperties', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
