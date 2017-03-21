# mdJson 2.0 writer tests - phone

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterPhone < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('phone.json')

   def test_schema_phone

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['contact'][0]['phone'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'contact.json', fragment: 'phone')
      assert_empty errors

   end

   def test_complete_phone

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['contact'][0]['phone']
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]['phone']

      assert_equal expect, got

   end

end
