# mdJson 2.0 writer tests - metadata info

# History:
#   Stan Smith 2017-03-13 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMetadataInfo < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('metadataInfo.json')

   def test_schema_metadataInfo

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'metadataInfo.json')
      assert_empty errors

   end

   def test_complete_metadataInfo

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']

      assert_equal expect, got

   end

end
