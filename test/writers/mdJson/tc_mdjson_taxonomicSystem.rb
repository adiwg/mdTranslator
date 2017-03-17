# mdJson 2.0 writer tests - taxonomic system

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTaxonomicSystem < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('taxonomicSystem.json')

   def test_schema_taxonomicSystem

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['taxonomy']['taxonomicSystem'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'taxonomicSystem')
      assert_empty errors

   end

   def test_complete_taxonomicSystem

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['taxonomy']['taxonomicSystem']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy']['taxonomicSystem']

      assert_equal expect, got

   end

end
