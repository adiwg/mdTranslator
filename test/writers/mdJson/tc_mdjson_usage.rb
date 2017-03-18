# mdJson 2.0 writer tests - resource usage

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterResourceUsage < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('usage.json')

   def test_schema_usage

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['resourceUsage'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'usage.json')
      assert_empty errors

   end

   def test_complete_usage

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['resourceUsage']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['resourceUsage']

      assert_equal expect, got

   end

end
