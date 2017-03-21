# mdJson 2.0 writer tests - associated resource

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterAssociatedResource < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('associatedResource.json')

   def test_schema_associatedResource

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['associatedResource'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'associatedResource.json')
      assert_empty errors

   end

   def test_complete_associatedResource

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['associatedResource']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['associatedResource']

      assert_equal expect, got

   end

end
