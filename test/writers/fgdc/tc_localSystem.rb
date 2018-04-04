# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-15 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcLocalPlanar < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_projection(hSpaceRef, 'localSystem')
   TDClass.add_localDesc(hSpaceRef, 'local description')
   TDClass.add_localGeoInfo(hSpaceRef, 'local georeference information')
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_localPlanar_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'localSystem',
                                                  './metadata/spref/horizsys/local')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_localPlanar_description

      # empty description
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:localPlanarDescription] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system description is missing: CONTEXT is local coordinate system not aligned with surface of earth'

      # missing description
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection].delete(:localPlanarDescription)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system description is missing: CONTEXT is local coordinate system not aligned with surface of earth'

   end

   def test_localPlanar_georeference

      # empty georeference
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:localPlanarGeoreference] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system georeference information is missing: CONTEXT is local coordinate system not aligned with surface of earth'

      # missing georeference
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection].delete(:localPlanarGeoreference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system georeference information is missing: CONTEXT is local coordinate system not aligned with surface of earth'

   end

end
