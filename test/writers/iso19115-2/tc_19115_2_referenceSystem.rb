# MdTranslator - minitest of
# writers / iso19115_2 / class_referenceSystem

# History:
#  Stan Smith 2018-10-17 refactor to support schema 2.6.0 changes to projection
#  Stan Smith 2018-04-27 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ReferenceSystem < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hIdentifier = TDClass.build_identifier('SRS001', 'ISO 19115-2',
                                          'srs version', 'spatial reference system identifier')
   hRefSystem = TDClass.build_spatialReference(nil, hIdentifier)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

   @@mdHash = mdHash

   # referenceSystem.systemType not used in 19115-2
   # referenceSystem.systemWKT not used in 19115-2
   # referenceSystem.systemParameterSet.verticalDatum not used in 19115-2

   def test_referenceSystem_identifier

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_referenceSystem',
                                                '//gmd:referenceSystemInfo[1]',
                                                '//gmd:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is spatial reference system authority citation'
   end

   def test_referenceSystem_parameterSet

      # not validated with XSD - MD_CRS was not added to XSD
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hParamSet = TDClass.build_parameterSet(true)
      hRefSystem = TDClass.build_spatialReference(nil,{}, hParamSet)

      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_referenceSystem',
                                                '//gmd:referenceSystemInfo[2]',
                                                '//gmd:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_referenceSystem_geodetic

      # not validated with XSD - MD_CRS was not added to XSD
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hParamSet = TDClass.build_parameterSet(false, true)
      hRefSystem = TDClass.build_spatialReference(nil,{}, hParamSet)

      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_referenceSystem',
                                                '//gmd:referenceSystemInfo[3]',
                                                '//gmd:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
