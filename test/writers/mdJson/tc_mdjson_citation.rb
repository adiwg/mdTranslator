# mdJson 2.0 writer tests - citation

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonCitation < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation] = TDClass.citation_full

   @@mdHash = mdHash

   def test_schema_citation

      hTest = @@mdHash[:metadata][:resourceInfo][:citation]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'citation.json')
      assert_empty errors

   end

   def test_complete_citation

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['citation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['citation']

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
