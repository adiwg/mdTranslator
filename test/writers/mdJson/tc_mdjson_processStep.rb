# mdJson 2.0 writer tests - process step

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonProcessStep < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base
   hLineage = TDClass.lineage
   hStep = TDClass.build_processStep('PST001','process step one')

   # time period {}
   hStep[:timePeriod] = TDClass.build_timePeriod('TP001','step time period', nil, '2018-04-26')

   # processor []
   hStep[:processor] << TDClass.build_responsibleParty('processor',%w(CID003))
   hStep[:processor] << TDClass.build_responsibleParty('pointOfContact',%w(CID004))

   # source steps []
   hStep[:stepSource] << TDClass.build_source('SRC001','step source one')
   hStep[:stepSource] << TDClass.build_source('SRC002','step source two')

   # step products []
   hStep[:stepProduct] << TDClass.build_source('SRC003','product source one')
   hStep[:stepProduct] << TDClass.build_source('SRC004','product source two')

   # step references []
   hStep[:reference] << TDClass.build_citation('step reference one')
   hStep[:reference] << TDClass.build_citation('step reference two')

   # scope
   hStep[:scope] = TDClass.build_scope

   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_schema_processStep

      hTest = @@mdHash[:metadata][:resourceLineage][0][:processStep][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json', :fragment=>'processStep')
      assert_empty errors

   end

   def test_complete_processStep

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceLineage'][0]['processStep']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['processStep']

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
