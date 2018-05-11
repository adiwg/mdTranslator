# MdTranslator - minitest of
# writers / iso19115_2 / class_timePeriod

# History:
#  Stan Smith 2018-05-02 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TimePeriod < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timePeriod',
                                                '//gmd:temporalElement[1]',
                                                '//gmd:temporalElement', 0)

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
      hTimePeriod.delete(:duration)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timePeriod',
                                                '//gmd:temporalElement[2]',
                                                '//gmd:temporalElement', 0)

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timePeriod',
                                                '//gmd:temporalElement[3]',
                                                '//gmd:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
