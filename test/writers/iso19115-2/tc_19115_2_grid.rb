# MdTranslator - minitest of
# writers / iso19115_2 / class_grid

# History:
#  Stan Smith 2018-04-24 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-03 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Grid < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGrid = TDClass.build_gridRepresentation
   TDClass.add_dimension(hGrid)
   TDClass.add_dimension(hGrid)
   hSpaceRep = TDClass.build_spatialRepresentation('grid', hGrid)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_grid_single_dimension

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_grid',
                                                '//gmd:spatialRepresentationInfo[1]',
                                                '//gmd:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_grid_multiple_dimension

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_grid',
                                                '//gmd:spatialRepresentationInfo[2]',
                                                '//gmd:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
