# mdJson 2.0 writer tests - resource info

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterResourceInfo < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('resourceInfo.json')

   def test_schema_resourceInfo

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'resourceInfo.json')
      assert_empty errors

   end

   def test_complete_resourceInfo

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']

      assert_equal expect, got

   end

end
