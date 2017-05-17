# mdJson 2.0 writer tests - citation

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonCitation < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('citation.json')

   def test_schema_citation

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['citation']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'citation.json')
      assert_empty errors

   end

   def test_complete_citation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['citation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['citation']

      assert_equal expect, got

   end

end
