# mdJson 2.0 writer tests - duration

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterDuration < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('duration.json')

   def test_schema_duration

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['extent'][0]['temporalExtent'][0]['timePeriod']['duration']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timePeriod.json', :fragment=>'duration')
      assert_empty errors

   end

   def test_complete_duration

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['extent'][0]['temporalExtent']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]['temporalExtent']

      assert_equal expect, got

   end

end
