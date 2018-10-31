# mdJson 2.0 writer tests - spatial reference parameters

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-10-24 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSpatialReferenceParameters < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []

   # all parameter set types
   hParams = TDClass.build_parameterSet(true, true, true)
   hSpaceRef = TDClass.build_spatialReference('all types', nil, hParams)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   # projection parameter set
   hParams = TDClass.build_parameterSet(true, false, false)
   hSpaceRef = TDClass.build_spatialReference('projection', nil, hParams)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   # geodetic parameter set
   hParams = TDClass.build_parameterSet(false, true, false)
   hSpaceRef = TDClass.build_spatialReference('geodetic', nil, hParams)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   # vertical parameter set
   hParams = TDClass.build_parameterSet(false, false, true)
   hSpaceRef = TDClass.build_spatialReference('vertical', nil, hParams)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_schema_referenceSystemParameterSet

      # oneOf projection
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'referenceSystemParameterSet.json', :remove => %w(geodetic verticalDatum))
      assert_empty errors

      # oneOf geodetic
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][2][:referenceSystemParameterSet]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'referenceSystemParameterSet.json', :remove => %w(projection verticalDatum))
      assert_empty errors

      # oneOf vrticalDatum
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:spatialReferenceSystem][3][:referenceSystemParameterSet]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'referenceSystemParameterSet.json', :remove => %w(projection geodetic))
      assert_empty errors

   end

   def test_complete_spatialReferenceParameters

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialReferenceSystem']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialReferenceSystem']

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
