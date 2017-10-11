# mdJson 2.0 writer tests - bounding box

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonBoundingBox < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('geographicExtent.json')

   # TODO remove after schema update
   # def test_schema_boundingBox
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['extent'][0]['geographicExtent'][0]['boundingBox']
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'geographicExtent.json', :fragment=>'boundingBox')
   #    assert_empty errors
   #
   # end

   def test_complete_boundingBox

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
