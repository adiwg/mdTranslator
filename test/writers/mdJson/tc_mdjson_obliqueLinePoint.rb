# mdJson 2.0 writer tests - oblique line point

# History:
#  Stan Smith 2018-10-18 refactor for mdJson schema 2.6.0
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

   hProjection = TDClass.build_projection('obliqueMercator', 'Oblique Mercator')
   TDClass.add_scaleFactorCL(hProjection)
   TDClass.add_obliqueLinePoint(hProjection)
   TDClass.add_obliqueLinePoint(hProjection)
   TDClass.add_latPO(hProjection)
   TDClass.add_falseNE(hProjection)

   hSpaceRef = TDClass.spatialReferenceSystem
   hSpaceRef[:referenceSystemParameterSet][:projection] = hProjection
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'spatial representation type'

   @@mdHash = mdHash

   def test_schema_obliqueLinePoint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hParameterSet = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet]
      hTest = hParameterSet[:projection][:obliqueLinePoint]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'projection.json', fragment: 'obliqueLinePoint')
      assert_empty errors

   end

   def test_complete_obliqueLinePoint

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
