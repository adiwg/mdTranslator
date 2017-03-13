# mdJson 2.0 writer tests - contact

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJson < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('contact.json')

   def test_contact_schema

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['contact'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'contact.json')
      assert_empty errors

   end

   def test_complete_contact

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['contact'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]

      assert_equal expect, got

   end

end
