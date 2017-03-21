# mdJson 2.0 writer tests - process step

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterProcessStep < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('processStep.json')

   def test_schema_processStep

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceLineage'][0]['processStep'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json', :fragment=>'processStep')
      assert_empty errors

   end

   def test_complete_processStep

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceLineage'][0]['processStep']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['processStep']

      assert_equal expect, got

   end

end
