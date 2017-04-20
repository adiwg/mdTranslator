# mdJson 2.0 writer tests - taxonomic classification

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTaxonomicClassification < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('taxonomicClassification.json')

   def test_schema_taxonomicClassification

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['taxonomy']['taxonomicClassification']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'taxonomicClassification')
      assert_empty errors

   end

   def test_complete_taxonomicClassification

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['taxonomy']['taxonomicClassification']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy']['taxonomicClassification']

      assert_equal expect, got

   end

end
