# mdJson 2.0 writer tests - locale

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonLocale < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('locale.json')

   def test_schema_locale

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']['defaultMetadataLocale']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'locale.json')
      assert_empty errors

   end

   def test_complete_locale

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
