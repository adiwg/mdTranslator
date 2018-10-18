# mdJson 2.0 writer tests - spatial resolution

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSpatialResolution < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialResolution] = []

   # scale factor
   hRes1 = TDClass.build_spatialResolution('factor')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes1

   # measure
   hRes2 = TDClass.build_spatialResolution('measure')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes2

   # coordinate resolution
   hRes3 = TDClass.build_spatialResolution('coordinate')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes3

   # bearing distance resolution
   hRes4 = TDClass.build_spatialResolution('bearing')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes4

   # geographic resolution
   hRes5 = TDClass.build_spatialResolution('geographic')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes5

   # level of detail
   hRes6 = TDClass.build_spatialResolution('detail')
   mdHash[:metadata][:resourceInfo][:spatialResolution] << hRes6

   @@mdHash = mdHash

   # TODO reinstate after schema update
   def test_schema_spatialResolution

      hTest = @@mdHash[:metadata][:resourceInfo][:spatialResolution]

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid scaleFactor
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[0])
      assert_empty errors

      # test vector measure
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[1])
      assert_empty errors

      # # test coordinate resolution
      # errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[2])
      # assert_empty errors

      # # test bearing distance resolution
      # errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[3])
      # assert_empty errors

      # # test geographic resolution
      # errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[4])
      # assert_empty errors

      # test georectified levelOfDetail
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[5])
      assert_empty errors

   end

   def test_complete_spatialResolution

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialResolution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialResolution']

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
