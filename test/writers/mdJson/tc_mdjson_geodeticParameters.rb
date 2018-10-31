# mdJson 2.0 writer tests - spatial reference ellipsoid parameters

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-10-24 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonGeodeticParameters < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hSpaceRef = TDClass.build_spatialReference('geodetic', TDClass.build_identifier('geoId one'), nil, 'WKT')
   TDClass.add_geodetic(hSpaceRef)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_schema_spatialReferenceParameters

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'spatialReference.json')
      assert_empty errors

   end

   def test_complete_geodeticParameters

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['geodetic']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['geodetic']

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
