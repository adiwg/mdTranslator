# mdJson 2.0 writer tests - series

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterSeries < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('series.json')

   def test_schema_series

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['citation']['series']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'citation.json', :fragment=>'series')
      assert_empty errors

   end

   def test_complete_series

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['citation']['series']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['citation']['series']

      assert_equal expect, got

   end

end
