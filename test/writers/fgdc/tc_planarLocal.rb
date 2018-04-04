# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-08 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapLocalPlanar < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson input file
   mdHash = TDClass.base
   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_projection(hSpaceRef, 'localPlanar')
   TDClass.add_localDesc(hSpaceRef)
   TDClass.add_localGeoInfo(hSpaceRef)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_map_localPlanar

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'mapLocal',
                                                  './metadata/spref/horizsys/planar/localp')
      assert_equal hReturn[0], hReturn[1]
      refute hReturn[2]

   end

   def test_map_localPlanar_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:localPlanarDescription] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:localPlanarGeoreference] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection local planar description is missing: CONTEXT is local right-handed planar coordinate system'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection local planar georeference information is missing: CONTEXT is local right-handed planar coordinate system'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection].delete(:localPlanarDescription)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection].delete(:localPlanarGeoreference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection local planar description is missing: CONTEXT is local right-handed planar coordinate system'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection local planar georeference information is missing: CONTEXT is local right-handed planar coordinate system'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

end
