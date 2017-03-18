# mdJson 2.0 writer tests - format

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterFormat < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('format.json')

   def test_schema_format

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['resourceFormat'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'format.json')
      assert_empty errors

   end

   def test_complete_format

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['resourceFormat'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['resourceFormat'][0]

      assert_equal expect, got

   end

end
