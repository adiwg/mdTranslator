# mdJson 2.0 writer tests - time period

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTimePeriod < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timePeriod: TDClass.build_timePeriod_full }

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_timePeriod

      # load all schemas with 'true' to prohibit additional parameters
      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # load schema segment and make all elements required and prevent additional parameters
      strictSchema = ADIWG::MdjsonSchemas::Utils.load_strict('timePeriod.json')

      # oneOf startDateTime/endDateTime
      hParameters = strictSchema['oneOf'][0]['properties']
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timePeriod]
      hTest.delete(:startGeologicAge)
      hTest.delete(:endGeologicAge)
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timePeriod.json', :remove => ['startGeologicAge, endGeologicAge'],
                                                 :addProperties => hParameters)
      assert_empty errors

      # oneOf startGeologicAge/endGeologicAge
      hParameters = strictSchema['oneOf'][1]['properties']
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timePeriod]
      hTest.delete(:startDateTime)
      hTest.delete(:endDateTime)
      hTest.delete(:timeInterval)
      hTest.delete(:duration)
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timePeriod.json', :remove => ['startDateTime, endDateTime'],
                                                 :addProperties => hParameters)
      assert_empty errors

   end

   def test_complete_timePeriod

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['extent'][0]['temporalExtent']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]['temporalExtent']

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
