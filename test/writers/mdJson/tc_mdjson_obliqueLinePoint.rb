# mdJson 2.0 writer tests - oblique line point

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-10-24 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonObliqueLinePoint < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_projection(hSpaceRef, 'obliqueMercator')
   TDClass.add_scaleFactorCL(hSpaceRef)
   TDClass.add_obliqueLinePoint(hSpaceRef)
   TDClass.add_obliqueLinePoint(hSpaceRef)
   TDClass.add_latPO(hSpaceRef)
   TDClass.add_falseNE(hSpaceRef)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   # TODO complete after schema update
   # def test_schema_obliqueLinePoint
   #
   #    hTest = @@mdHash[:metadata][:resourceInfo][:spatialReferenceSystem][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'spatialReference.json')
   #    assert_empty errors
   #
   # end

   def test_complete_obliqueLinePoint

      # TODO validate normal after schema update
      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']

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
