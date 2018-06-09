# mdJson 2.0 writer tests - identifier

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonIdentifier < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation][:identifier] = []
   mdHash[:metadata][:resourceInfo][:citation][:identifier] << TDClass.build_identifier('citation identifier one')

   @@mdHash = mdHash

   def test_schema_identifier

      hTest = @@mdHash[:metadata][:resourceInfo][:citation][:identifier][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'identifier.json')
      assert_empty errors

   end

   def test_complete_identifier

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['citation']['identifier']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['citation']['identifier']

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
