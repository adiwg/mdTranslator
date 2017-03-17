# mdJson 2.0 writer tests - taxonomy

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTaxonomy < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('taxonomy.json')

   def test_schema_taxonomy

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['taxonomy']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json')
      assert_empty errors

   end

   def test_complete_taxonomy

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['taxonomy']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy']

      assert_equal expect, got

   end

end
