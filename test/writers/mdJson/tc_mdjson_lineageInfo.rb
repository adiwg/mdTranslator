# mdJson 2.0 writer tests - lineage

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonLineageInfo < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.build_lineage

   hLineage[:citation] << TDClass.build_citation('lineage citation two', 'CID003')

   hLineage[:processStep] << TDClass.build_processStep('PST001','process step one')
   hLineage[:processStep] << TDClass.build_processStep('PST002','process step two')

   hLineage[:source] << TDClass.build_source('SRC001','source one')
   hLineage[:source] << TDClass.build_source('SRC002','source two')

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_schema_lineage

      hTest = @@mdHash[:metadata][:resourceLineage][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json')
      assert_empty errors

   end

   def test_complete_lineage

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceLineage']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage']

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
