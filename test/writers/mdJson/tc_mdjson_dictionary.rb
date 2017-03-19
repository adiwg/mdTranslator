# mdJson 2.0 writer tests - dictionary

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterDictionary < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('dictionary.json')

   def test_schema_dictionary

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['dataDictionary'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'dataDictionary.json')
      assert_empty errors

   end

   def test_complete_dictionary

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['dataDictionary']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary']

      assert_equal expect, got

   end

end
