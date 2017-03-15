# mdJson 2.0 writer tests - address

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterAddress < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('address.json')

   def test_schema_address

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['contact'][0]['address'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'contact.json', fragment: 'address')
      assert_empty errors

   end

   def test_complete_address

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['contact'][0]['address']
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]['address']

      assert_equal expect, got

   end

end
