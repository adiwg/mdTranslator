# mdJson 2.0 writer tests - processing

# History:
#  Stan Smith 2019-09-24 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonProcessing < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage
   hLineage[:processStep] << TDClass.processStep
   hLineage[:processStep][0][:processingInformation] = TDClass.build_processing_full
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   # TODO refactor after schema update
   # def test_schema_address
   #
   #    hTest = @@mdHash[:contact][0][:address][1]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'contact.json', fragment: 'address')
   #    assert_empty errors
   #
   # end

   def test_complete_processing

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceLineage'][0]['processStep'][0]['processingInformation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['processStep'][0]['processingInformation']

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
