# mdJson 2.0 writer tests - online resource

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonOnlineResource < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:contact][0][:onlineResource] = []
   mdHash[:contact][0][:onlineResource] << TDClass.build_onlineResource('https://adiwg.org/1')

   @@mdHash = mdHash

   def test_schema_onlineResource

      hTest = @@mdHash[:contact][0][:onlineResource][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'onlineResource.json')
      assert_empty errors

   end

   def test_complete_onlineResource

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['contact'][0]['onlineResource']
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]['onlineResource']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
