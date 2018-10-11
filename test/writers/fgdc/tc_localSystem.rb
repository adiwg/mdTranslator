# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-01-15 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcLocalPlanar < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hProjection = TDClass.build_projection('localSystem', 'Local System')
   TDClass.add_localSystem(hProjection)

   hSpaceRef = TDClass.spatialReferenceSystem
   hSpaceRef[:referenceSystemParameterSet][:projection] = hProjection
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'spatial representation type'

   @@mdHash = mdHash

   def test_localSystem_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'localSystem',
                                                  './metadata/spref/horizsys/local')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_map_localSystem_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hLocal = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:local]
      hLocal[:description] = ''
      hLocal[:georeference] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
         'ERROR: FGDC writer: local coordinate system description is missing: CONTEXT is spatial reference'
      assert_includes hResponseObj[:writerMessages],
         'ERROR: FGDC writer: local coordinate system georeference information is missing: CONTEXT is spatial reference'

      # missing elements
      hLocal.delete(:description)
      hLocal.delete(:georeference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system description is missing: CONTEXT is spatial reference'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: local coordinate system georeference information is missing: CONTEXT is spatial reference'

   end

end
