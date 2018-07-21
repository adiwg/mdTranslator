# mdJson 2.0 writer tests - keyword object

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonKeywordObject < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_schema_keywordObject

      hTest = @@mdHash[:metadata][:resourceInfo][:keyword][0][:keyword][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'keyword.json', :fragment=>'keywordObject')
      assert_empty errors

   end

end
