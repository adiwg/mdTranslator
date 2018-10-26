# mdJson 2.0 writer tests - taxonomic system

# History:
#  Stan Smith 2018-10-27 refactor for mdJson schema 2.6.0
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTaxonomicSystem < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.build_taxonomy_full

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   def test_schema_taxonomicSystem

      hTest = @@mdHash[:metadata][:resourceInfo][:taxonomy][0][:taxonomicSystem][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'taxonomicSystem')
      assert_empty errors

   end

   def test_complete_taxonomicSystem

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]['taxonomicSystem']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]['taxonomicSystem']

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
