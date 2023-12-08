# MdTranslator - minitest of
# writers / iso19115_3 / class_georectified

# History:
#  Stan Smith 2019-04-29 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Georectified < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoRep = TDClass.build_georectifiedRepresentation
   hSpaceRep = TDClass.build_spatialRepresentation('georectified', hGeoRep)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   # def test_georectified_complete
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #
   #    hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georectified',
   #                                              '//mdb:spatialRepresentationInfo[1]',
   #                                              '//mdb:spatialRepresentationInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   # end

   # def test_georectified_elements
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    hGeoRec = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georectifiedRepresentation]
   #
   #    # empty elements
   #    hGeoRec[:checkPointDescription] = ''
   #    hGeoRec[:transformationDimensionDescription] = ''
   #    hGeoRec[:transformationDimensionMapping] = ''
   #
   #    hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georectified',
   #                                              '//mdb:spatialRepresentationInfo[2]',
   #                                              '//mdb:spatialRepresentationInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   #    # missing elements
   #    hGeoRec.delete(:checkPointDescription)
   #    hGeoRec.delete(:centerPoint)
   #    hGeoRec.delete(:transformationDimensionDescription)
   #    hGeoRec.delete(:transformationDimensionMapping)
   #
   #    hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georectified',
   #                                              '//mdb:spatialRepresentationInfo[3]',
   #                                              '//mdb:spatialRepresentationInfo', 0)
   #
   #    assert_equal hReturn[0], hReturn[1]
   #    assert hReturn[2]
   #    assert_empty hReturn[3]
   #
   # end

   def test_georectified_4_corners

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoRec = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georectifiedRepresentation]
      hGeoRec.delete(:checkPointDescription)
      hGeoRec.delete(:centerPoint)
      hGeoRec.delete(:transformationDimensionDescription)
      hGeoRec.delete(:transformationDimensionMapping)
      hGeoRec[:cornerPoints] = [
         [100.0, 50.0],
         [100.0, 25.0],
         [25.0, 25.0],
         [25.0, 50.0]
      ]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georectified',
                                                '//mdb:spatialRepresentationInfo[4]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
