# MdTranslator - minitest of
# writers / iso19115_2 / class_resolution

# History:
#  Stan Smith 2018-04-27 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-02 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Resolution < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   # coordinate resolution not supported in ISO 19115-2
   # bearing-distance resolution not supported in ISO 19115-2
   # geographic resolution not supported in ISO 19115-2
   # levelOfDetail resolution not supported in ISO 19115-2

   def test_spatialResolution_scaleFactor

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << { scaleFactor: 9999 }

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_resolution',
                                                '//gmd:spatialResolution[1]',
                                                '//gmd:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialResolution_distance

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << { measure: TDClass.measure }

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_resolution',
                                                '//gmd:spatialResolution[2]',
                                                '//gmd:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_spatialResolution_unsupported_measure

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << { measure: TDClass.measure }
      hIn[:metadata][:resourceInfo][:spatialResolution][0][:measure][:type] = 'angle'

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_resolution',
                                                '//gmd:spatialResolution[3]',
                                                '//gmd:spatialResolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
