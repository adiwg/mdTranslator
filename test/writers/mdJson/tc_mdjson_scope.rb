# mdJson 2.0 writer tests - scope

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterScope < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('scope.json')

   def test_schema_scope

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']['metadataMaintenance']['scope'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'scope.json')
      assert_empty errors

   end

   def test_complete_scope

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']['metadataMaintenance']['scope']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataMaintenance']['scope']

      assert_equal expect, got

   end

end
