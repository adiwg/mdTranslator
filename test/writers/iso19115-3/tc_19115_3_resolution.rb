# MdTranslator - minitest of
# writers / iso19115_3 / class_resolution

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Resolution < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   # coordinate resolution not supported in ISO 19115-3
   # bearing-distance resolution not supported in ISO 19115-3
   # geographic resolution not supported in ISO 19115-3

   def test_spatialResolution_scaleFactor

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << { scaleFactor: 9999 }

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_resolution',
                                                '//mri:spatialResolution[1]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialResolution_measure

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] <<
         { measure: TDClass.build_measure('distance', '999', 'meters')}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_resolution',
                                                '//mri:spatialResolution[2]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialResolution_levelOfDetail

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << { levelOfDetail: 'level of detail'}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_resolution',
                                                '//mri:spatialResolution[3]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end


end
