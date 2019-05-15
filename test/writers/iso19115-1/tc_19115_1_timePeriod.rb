# MdTranslator - minitest of
# writers / iso19115_1 / class_timePeriod

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151TimePeriod < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimeP = TDClass.build_timePeriod('TPID001',nil,'2017-05-02','2018-05-02T08:46')
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timePeriod: hTimeP }
   mdHash[:metadata][:resourceInfo][:extent][0].delete(:geographicExtent)

   @@mdHash = mdHash

   def test_timePeriod_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_timePeriod',
                                                '//gex:temporalElement[1]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timePeriod_start

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timePeriod]
      hTimePeriod.delete(:id)
      hTimePeriod.delete(:description)
      hTimePeriod.delete(:identifier)
      hTimePeriod.delete(:periodName)
      hTimePeriod.delete(:endDateTime)
      hTimePeriod.delete(:timeInterval)
      # hTimePeriod.delete(:duration)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_timePeriod',
                                                '//gex:temporalElement[2]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timePeriod_end

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timePeriod]
      hTimePeriod.delete(:id)
      hTimePeriod.delete(:description)
      hTimePeriod.delete(:identifier)
      hTimePeriod.delete(:periodName)
      hTimePeriod.delete(:startDateTime)
      hTimePeriod.delete(:timeInterval)
      hTimePeriod.delete(:duration)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_timePeriod',
                                                '//gex:temporalElement[3]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
