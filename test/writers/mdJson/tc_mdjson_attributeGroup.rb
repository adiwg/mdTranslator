# mdJson 2.0 writer tests - attribute group

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAttributeGroup < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('attributeGroup.json')

   def test_schema_attributeGroup

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'attributeGroup.json')
      assert_empty errors

   end

   def test_complete_attributeGroup

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['coverageDescription'][0]['attributeGroup']

      assert_equal expect, got

   end

end
