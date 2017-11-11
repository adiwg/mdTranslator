# mdJson 2.0 writer tests - geologic age

# History:
#  Stan Smith 2017-11-08 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonGeologicAge < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('geologicAge.json')

   # TODO complete after schema update
   # def test_schema_geologicAge
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['citation']['series']
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'citation.json', :fragment=>'series')
   #    assert_empty errors
   #
   # end

   def test_complete_geologicAge

      # TODO reinstate 'normal' after schema update
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['extent'][0]['temporalExtent'][0]['timePeriod']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]['temporalExtent'][0]['timePeriod']

      assert_equal expect, got

   end

end
