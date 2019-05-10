# MdTranslator - minitest of
# writers / iso19115_1 / class_measure

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Measure < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base
   mdHash[:metadata][:resourceInfo][:spatialResolution] = []

   @@mdHash = mdHash

   # length not supported in 19115-1
   # scale not supported in 19115-1

   def test_measure_distance

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] <<
         { measure: TDClass.build_measure('distance', '999', 'meters')}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_measure',
                                                '//mri:spatialResolution[1]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_measure_angle

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] <<
         { measure: TDClass.build_measure('angle', '60', 'degrees')}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_measure',
                                                '//mri:spatialResolution[2]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_measure_vertical

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] <<
         { measure: TDClass.build_measure('vertical', '10000', 'feet')}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_measure',
                                                '//mri:spatialResolution[3]',
                                                '//mri:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
