# mdJson 2.0 writer tests - spatial representation

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSpatialRepresentation < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []

   # grid
   hGrid = TDClass.build_gridRepresentation
   TDClass.add_dimension(hGrid)
   TDClass.add_dimension(hGrid)
   hSpaceRep1 = TDClass.build_spatialRepresentation('grid', hGrid)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep1

   # vector
   hVector = TDClass.build_vectorRepresentation('topology level')
   TDClass.add_vectorObject(hVector,'type one', 1)
   TDClass.add_vectorObject(hVector,'type two', 2)
   hSpaceRep2 = TDClass.build_spatialRepresentation('vector', hVector)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep2

   # georectified
   hGeoRep = TDClass.build_georectifiedRepresentation
   hSpaceRep3 = TDClass.build_spatialRepresentation('georectified', hGeoRep)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep3

   # georeferenceable
   hGeoRef = TDClass.build_georeferenceableRepresentation
   hSpaceRep4 = TDClass.build_spatialRepresentation('georeferenceable', hGeoRef)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep4

   @@mdHash = mdHash

   def test_schema_spatialRepresentation

      hTest = @@mdHash[:metadata][:resourceInfo][:spatialRepresentation]

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[0])
      assert_empty errors

      # test vector representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[1])
      assert_empty errors

      # test georectified representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[2])
      assert_empty errors

      # test georeferenceable representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[3])
      assert_empty errors

   end

   def test_complete_spatialRepresentation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
