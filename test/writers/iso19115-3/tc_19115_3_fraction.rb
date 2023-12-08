# MdTranslator - minitest of
# writers / iso19115_3 / class_fraction

# History:
#  Stan Smith 2019-04-25 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Fraction < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialResolution] = []
   mdHash[:metadata][:resourceInfo][:spatialResolution] << { scaleFactor: 99999 }

   @@mdHash = mdHash

   def test_spatialResolution_scaleFactor

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_fraction',
                                                '//mri:equivalentScale[1]',
                                                '//mri:equivalentScale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
