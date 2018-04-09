# mdJson 2.0 writer tests - taxonomy

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTaxonomy < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('taxonomy.json')

   # TODO reinstate after schema update
   # def test_schema_taxonomy
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['taxonomy']
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json')
   #    assert_empty errors
   #
   # end

   def test_complete_taxonomy

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none', writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]

      assert_equal expect, got

   end

end
