# mdJson 2.0 writer tests - vector object

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterVectorObject < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('vectorObject.json')

   def test_schema_vectorObject

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']['vectorObject'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'vectorRepresentation.json', :fragment=>'vectorObject')
      assert_empty errors

   end

   def test_complete_vectorObject

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']['vectorObject']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']['vectorObject']

      assert_equal expect, got

   end

end
