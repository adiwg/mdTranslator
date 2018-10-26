# mdJson 2.0 writer tests - taxonomic classification

# History:
#  Stan Smith 2018-10-27 refactor for mdJson schema 2.6.0
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTaxonomicClassification < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.build_taxonomy_full
   hTaxonomy[:taxonomicClassification][1] = TDClass.build_taxonomyClassification_full

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_schema_taxonomicClassification
   #
   #    hTest = @@mdHash[:metadata][:resourceInfo][:taxonomy][0][:taxonomicClassification][1]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'taxonomicClassification')
   #    assert_empty errors
   #
   # end

   def test_complete_taxonomicClassification

      # TODO validate 'normal' after schema update
      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]['taxonomicClassification']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]['taxonomicClassification']

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
