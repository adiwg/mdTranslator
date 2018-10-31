# mdJson 2.0 writer tests - oblique line point

# History:
#  Stan Smith 2018-10-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonLocalProjection < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   def run_test(hProjection)

      # build mdJson test file in hash
      mdHash = TDClass.base

      hSpaceRef = TDClass.spatialReferenceSystem
      hSpaceRef[:referenceSystemParameterSet][:projection] = hProjection
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'spatial representation type'

      @@mdHash = mdHash

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

   def test_schema_localProjection

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:projection][:local]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'projection.json', fragment: 'local')
      assert_empty errors

   end

   def test_complete_localPlanar

      hProjection = TDClass.build_projection('localPlanar', 'Local Planar Coordinate Projection')
      TDClass.add_localPlanar(hProjection)

      run_test(hProjection)

   end

   def test_complete_localSystem

      hProjection = TDClass.build_projection('localSystem', 'Local System Coordinate Projection')
      TDClass.add_localSystem(hProjection)

      run_test(hProjection)

   end

end
