# mdJson 2.0 writer tests - time period

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTimePeriod < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('timePeriod.json')

   def test_schema_timePeriod

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']['defaultMetadataLocale']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timePeriod.json')
      assert_empty errors

   end

   def test_complete_timePeriod

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']['defaultMetadataLocale']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['defaultMetadataLocale']

      assert_equal expect, got

   end

end
