# mdJson 2.0 writer tests - online resource

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonOnlineResource < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('onlineResource.json')

   def test_schema_onlineResource

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['contact'][0]['onlineResource'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'onlineResource.json')
      assert_empty errors

   end

   def test_complete_onlineResource

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['contact'][0]['onlineResource']
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]['onlineResource']

      assert_equal expect, got

   end

end
