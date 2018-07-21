# mdJson 2.0 writer tests - temporal extent

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTemporalExtent < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimeP = TDClass.build_timePeriod('TPID001',nil,'2017-05-02','2018-05-02T08:46')
   hTimeI = TDClass.build_timeInstant('TIID001',nil,'2018-05-02T08:48:00-00:09')
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timePeriod: hTimeP }
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timeInstant: hTimeI }

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_temporalExtent

      hTest = @@mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent]

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test timeInstant
      errors = JSON::Validator.fully_validate('temporalExtent.json', hTest[0])
      assert_empty errors

      # test timePeriod
      errors = JSON::Validator.fully_validate('temporalExtent.json', hTest[1])
      assert_empty errors

   end

   def test_complete_temporalExtent

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['extent'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]

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
