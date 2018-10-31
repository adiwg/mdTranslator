# mdJson 2.0 writer tests - time instant

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTimeInstant < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimeI = TDClass.build_timeInstant('TIID001',nil,'2018-05-02T08:48:00-00:09')
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timeInstant: hTimeI }
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timeInstant: TDClass.build_timeInstant_full }

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_timeInstant

      # oneOf dateTime
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timeInstant]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timeInstant.json', :remove => ['geologicAge'])
      assert_empty errors

      # oneOf geologicAge
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][1][:timeInstant]
      hTest.delete(:dateTime)
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timeInstant.json', :remove => ['dateTime'])
      assert_empty errors

   end

   def test_complete_timeInstant

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
