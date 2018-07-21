# mdJson 2.0 writer tests - keyword

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonKeyword < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hKeywords1 = TDClass.build_keywords
   TDClass.add_keyword(hKeywords1,'keyword one')
   TDClass.add_keyword(hKeywords1,'keyword two', 'KWID001')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeywords1

   @@mdHash = mdHash

   def test_schema_keyword

      hTest = @@mdHash[:metadata][:resourceInfo][:keyword][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'keyword.json')
      assert_empty errors

   end

   def test_complete_format

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['keyword']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['keyword']

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
