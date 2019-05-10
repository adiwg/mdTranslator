# MdTranslator - minitest of
# writers / iso19115_1 / class_referenceSystem

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151ReferenceSystem < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []

   @@mdHash = mdHash

   def test_referenceSystem_identifier

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIdentifier = TDClass.build_identifier('SRS001', 'ISO 19115-1', 'srs version',
                                             'spatial reference system identifier')
      hRefSystem = TDClass.build_spatialReference(nil, hIdentifier)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_referenceSystem',
                                                '//mdb:referenceSystemInfo[1]',
                                                '//mdb:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_referenceSystem_wkt

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hRefSystem = TDClass.build_spatialReference(nil, nil, nil, 'WKT POINT 1')
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_referenceSystem',
                                                '//mdb:referenceSystemInfo[2]',
                                                '//mdb:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_referenceSystem_parameterSet

      # not validated with XSD - MD_CRS was not added to XSD
      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hParamSet = TDClass.build_parameterSet(true)
      hRefSystem = TDClass.build_spatialReference(nil,{}, hParamSet)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_referenceSystem',
                                                '//mdb:referenceSystemInfo[3]',
                                                '//mdb:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_referenceSystem_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hParamSet = TDClass.build_parameterSet(true)
      hRefSystem = TDClass.build_spatialReference(nil,{}, hParamSet)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      # empty elements
      hRefSystem[:referenceSystemType] = ''
      hRefSystem[:referenceSystemIdentifier] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_referenceSystem',
                                                '//mdb:referenceSystemInfo[4]',
                                                '//mdb:referenceSystemInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      refute hReturn[2]
      assert_equal 2, hReturn[3].length
      assert_includes hReturn[3], 'ERROR: ISO-19115-1 writer: spatial reference system identifier is missing: CONTEXT is resource spatial reference system'
      assert_includes hReturn[3], 'ERROR: ISO-19115-1 writer: spatial reference system type is missing: CONTEXT is resource spatial reference system'

   end

end
