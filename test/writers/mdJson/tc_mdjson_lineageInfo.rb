# mdJson 2.0 writer tests - lineage

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterLineageInfo < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('lineageInfo.json')

   def test_schema_lineage

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceLineage'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json')
      assert_empty errors

   end

   def test_complete_lineage

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceLineage']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage']

      assert_equal expect, got

   end

end
