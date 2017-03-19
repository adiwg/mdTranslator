# mdJson 2.0 writer tests - maintenance

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMaintenance < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('maintenance.json')

   def test_schema_maintenance

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']['metadataMaintenance']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'maintInfo.json')
      assert_empty errors

   end

   def test_complete_maintenance

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']['metadataMaintenance']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataMaintenance']

      assert_equal expect, got

   end

end
