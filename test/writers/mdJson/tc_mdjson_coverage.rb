# mdJson 2.0 writer tests - coverage description

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonCoverageDescription < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage = TDClass.build_coverageDescription
   hCoverage[:attributeGroup] << TDClass.build_attributeGroup
   hCoverage[:attributeGroup] << TDClass.build_attributeGroup
   TDClass.add_imageDescription(hCoverage)
   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage

   @@mdHash = mdHash

   def test_schema_coverage

      hTest = @@mdHash[:metadata][:resourceInfo][:coverageDescription][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'coverageDescription.json')
      assert_empty errors

   end

   def test_complete_coverage

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['coverageDescription']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['coverageDescription']

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
