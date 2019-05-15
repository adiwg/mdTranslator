# MdTranslator - minitest of
# writers / iso19115_1 / class_temporalExtent

# History:
#  Stan Smith 2019-05-05 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151TemporalExtent < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimeP = TDClass.build_timePeriod('TPID001',nil,'2017-05-02','2018-05-02T08:46')
   hTimeI = TDClass.build_timeInstant('TIID001',nil,'2018-05-02T08:48:00-00:09')
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timePeriod: hTimeP }
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timeInstant: hTimeI }
   mdHash[:metadata][:resourceInfo][:extent][0].delete(:geographicExtent)

   @@mdHash = mdHash

   def test_temporalExtent_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_temporalExtent',
                                                '//gex:temporalElement[1]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_temporalExtent',
                                                '//gex:temporalElement[2]',
                                                '//gex:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
