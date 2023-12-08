# MdTranslator - minitest of
# writers / iso19115_3 / class_georeferenceable

# History:
#  Stan Smith 2019-04-29 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Georeferenceable < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoRep = TDClass.build_georeferenceableRepresentation
   hSpaceRep = TDClass.build_spatialRepresentation('georeferenceable', hGeoRep)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_georeferenceable_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoRef = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georeferenceableRepresentation]
      hGeoRef[:parameterCitation].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georeferenceable',
                                                '//mdb:spatialRepresentationInfo[1]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_georeferenceable_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georeferenceable',
                                                '//mdb:spatialRepresentationInfo[2]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_georeferenceable_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoRef = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georeferenceableRepresentation]

      # empty elements
      hGeoRef[:orientationParameterDescription] = ''
      hGeoRef[:parameterCitation] = []

          hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georeferenceable',
                                                '//mdb:spatialRepresentationInfo[3]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hGeoRef.delete(:orientationParameterDescription)
      hGeoRef.delete(:parameterCitation)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_georeferenceable',
                                                '//mdb:spatialRepresentationInfo[4]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
