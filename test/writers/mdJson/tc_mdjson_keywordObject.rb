# mdJson 2.0 writer tests - keyword object

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterKeywordObject < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('keyword.json')

   def test_schema_keywordObject

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['keyword'][0]['keyword'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'keyword.json', :fragment=>'keywordObject')
      assert_empty errors

   end

end
