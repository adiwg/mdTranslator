# mdJson 2.0 writer tests - additional documentation

# History:
#  Stan Smith 2018-05-31 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAdditionalDocumentation < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:additionalDocumentation] = []
   mdHash[:metadata][:additionalDocumentation] << TDClass.additionalDocumentation
   mdHash[:metadata][:additionalDocumentation] << TDClass.additionalDocumentation

   mdHash[:metadata][:additionalDocumentation][0][:resourceType] << {type: 'resource type two'}
   hCitation = TDClass.build_citation('additional documentation citation title two')
   mdHash[:metadata][:additionalDocumentation][0][:citation] << hCitation

   @@mdHash = mdHash

   def test_schema_additionalDocumentation

      hTest = @@mdHash[:metadata][:additionalDocumentation][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'additionalDocumentation.json')
      assert_empty errors

   end

   def test_complete_additionalDocumentation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['additionalDocumentation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['additionalDocumentation']

      pass = metadata[:writerPass] && metadata[:readerStructurePass] &&
         metadata[:readerValidationPass] && metadata[:readerExecutionPass]

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
