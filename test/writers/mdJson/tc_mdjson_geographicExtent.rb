# mdJson 2.0 writer tests - geographic extent

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterGeographicExtent < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('geographicExtent.json')

   def test_schema_geographicExtent

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['extent'][0]['geographicExtent'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'geographicExtent.json')
      assert_empty errors

   end

   def test_complete_geographicExtent

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
