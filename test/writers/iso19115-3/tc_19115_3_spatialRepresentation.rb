# MdTranslator - minitest of
# writers / iso19115_3 / class_spatialRepresentation

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151SpatialRepresentation < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # build sources
  mdHash[:metadata][:resourceInfo][:spatialRepresentation] = TDClass.build_spatialRepresentation_full

   @@mdHash = mdHash

   def test_spatialRepresentation_grid

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_spatialRepresentation',
                                                '//mdb:spatialRepresentationInfo[1]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialRepresentation_vector

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_spatialRepresentation',
                                                '//mdb:spatialRepresentationInfo[2]',
                                                '//mdb:spatialRepresentationInfo', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialRepresentation_georectified

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_spatialRepresentation',
                                                '//mdb:spatialRepresentationInfo[3]',
                                                '//mdb:spatialRepresentationInfo', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialRepresentation_georeferenceable

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_spatialRepresentation',
                                                '//mdb:spatialRepresentationInfo[4]',
                                                '//mdb:spatialRepresentationInfo', 3)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
