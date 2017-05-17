# mdJson 2.0 writer tests - entity attribute

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonEntityAttribute < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('entityAttribute.json')

   def test_schema_entityAttribute

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['dataDictionary'][0]['entity'][0]['attribute'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'entity.json', :fragment=>'attribute')
      assert_empty errors

   end

   def test_complete_entityAttribute

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['dataDictionary'][0]['entity'][0]['attribute']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['entity'][0]['attribute']

      assert_equal expect, got

   end

end
