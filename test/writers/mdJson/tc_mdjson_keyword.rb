# mdJson 2.0 writer tests - keyword

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonKeyword < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('keyword.json')

   def test_schema_keyword

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['keyword'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'keyword.json')
      assert_empty errors

   end

   def test_complete_format

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['keyword']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['keyword']

      assert_equal expect, got

   end

end
