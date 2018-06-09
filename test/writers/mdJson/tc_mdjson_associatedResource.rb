# mdJson 2.0 writer tests - associated resource

# History:
#  Stan Smith 2018-05-31 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAssociatedResource < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource(nil, 'citation title two')

   mdHash[:metadata][:associatedResource][0][:resourceType] << {type: 'resource type two'}

   @@mdHash = mdHash

   def test_schema_associatedResource

      hTest = @@mdHash[:metadata][:associatedResource][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'associatedResource.json')
      assert_empty errors

   end

   def test_complete_associatedResource

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['associatedResource']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['associatedResource']

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
