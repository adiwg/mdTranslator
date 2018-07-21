# mdJson 2.0 writer tests - taxonomic classification

# History:
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

   hTaxonomy = TDClass.taxonomy

   hLevel0 = hTaxonomy[:taxonomicClassification]
   hLevel0[:taxonomicSystemId] = 'ITIS-1234-1234-abcd'
   hLevel0[:taxonomicLevel] = 'kingdom'
   hLevel0[:taxonomicName] = 'animalia'
   hLevel0[:commonName] = ['animals']
   TDClass.add_taxonClass(hLevel0, 'subkingdom', 'bilateria')

   hLevel1 = hLevel0[:subClassification][0]
   TDClass.add_taxonClass(hLevel1, 'subfamily', 'anserinae')

   hLevel2 = hLevel1[:subClassification][0]
   TDClass.add_taxonClass(hLevel2, 'genus', 'branta')
   TDClass.add_taxonClass(hLevel2, 'genus', 'anser', ['brent geese'])

   hLevel20 = hLevel2[:subClassification][0]
   hLevel21 = hLevel2[:subClassification][1]
   TDClass.add_taxonClass(hLevel20, 'species', 'branta bernicla', ['brant goose','ganso de collar'])
   TDClass.add_taxonClass(hLevel21, 'species', 'albifrons')

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_schema_taxonomicClassification
   #
   #    hTest = @@mdHash[:metadata][:resourceInfo][:taxonomy][0][:taxonomicClassification]
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
