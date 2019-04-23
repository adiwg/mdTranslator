# mdJson 2.0 writer tests - resource usage

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonResourceUsage < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:resourceUsage] = []
   mdHash[:metadata][:resourceInfo][:resourceUsage] << TDClass.build_resourceUsage(usage: 'usage one')

   @@mdHash = mdHash

   def test_schema_usage

      hTest = @@mdHash[:metadata][:resourceInfo][:resourceUsage][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'usage.json')
      assert_empty errors

   end

   def test_complete_usage

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['resourceUsage']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['resourceUsage']

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
