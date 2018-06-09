# mdJson 2.0 writer tests - metadata

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-20 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMetadata < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # lineage []
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << TDClass.build_lineage
   mdHash[:metadata][:resourceLineage] << TDClass.build_lineage

   # distribution []
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << TDClass.build_distribution
   mdHash[:metadata][:resourceDistribution] << TDClass.build_distribution

   # associated resource []
   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource

   # additional documentation []
   mdHash[:metadata][:additionalDocumentation] = [TDClass.build_additionalDocumentation]
   mdHash[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation
   mdHash[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation

   # funding []
   mdHash[:metadata][:funding] = []
   mdHash[:metadata][:funding] << TDClass.build_funding
   mdHash[:metadata][:funding] << TDClass.build_funding

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_metadata

      hTest = @@mdHash[:metadata]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'metadata.json')
      assert_empty errors

   end

   def test_complete_metadata

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']

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
