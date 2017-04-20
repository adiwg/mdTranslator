# mdJson 2.0 writer tests - metadata

# History:
#   Stan Smith 2017-03-20 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMetadata < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('metadata.json')

   def test_schema_metadata

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'metadata.json')
      assert_empty errors

   end

   def test_complete_metadata

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']

      assert_equal expect, got

   end

end
