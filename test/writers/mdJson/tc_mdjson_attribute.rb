# mdJson 2.0 writer tests - attribute

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterAttribute < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('attribute.json')

   def test_schema_attribute

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup'][0]['attribute'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'attribute.json')
      assert_empty errors

   end

   def test_complete_attribute

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup'][0]['attribute']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup'][0]['attribute']

      assert_equal expect, got

   end

end
