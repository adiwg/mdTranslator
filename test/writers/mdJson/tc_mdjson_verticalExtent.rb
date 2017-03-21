# mdJson 2.0 writer tests - vertical extent

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterVerticalExtent < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('verticalExtent.json')

   def test_schema_verticalExtent

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['extent'][0]['verticalExtent'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'verticalExtent.json')
      assert_empty errors

   end

   def test_complete_verticalExtent

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['extent'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]

      assert_equal expect, got

   end

end
