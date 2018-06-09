# MdTranslator - minitest of
# writers / iso19115_2 / class_georeferenceable

# History:
#  Stan Smith 2018-04-23 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-02 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Georeferenceable < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoRep = TDClass.build_georeferenceableRepresentation
   hSpaceRep = TDClass.build_spatialRepresentation('georeferenceable', hGeoRep)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_georeferenceable_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_georeferenceable',
                                                '//gmd:spatialRepresentationInfo[1]',
                                                '//gmd:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 2, hReturn[3].length
      assert_includes hReturn[3],
         'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is georeferenceable representation citation'

   end

   def test_georeferenceable_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoRef = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georeferenceableRepresentation]
      hGeoRef[:parameterCitation].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_georeferenceable',
                                                '//gmd:spatialRepresentationInfo[2]',
                                                '//gmd:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is georeferenceable representation citation'

   end

   def test_georeferenceable_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoRef = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:georeferenceableRepresentation]
      hGeoRef.delete(:orientationParameterDescription)
      hGeoRef.delete(:parameterCitation)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_georeferenceable',
                                                '//gmd:spatialRepresentationInfo[3]',
                                                '//gmd:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
