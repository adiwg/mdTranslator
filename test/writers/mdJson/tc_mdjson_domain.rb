# mdJson 2.0 writer tests - domain

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDomain < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('domain.json')

   def test_schema_domain

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['dataDictionary'][0]['domain'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'domain.json')
      assert_empty errors

   end

   def test_complete_domain

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['dataDictionary'][0]['domain']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['domain']

      assert_equal expect, got

   end

end
