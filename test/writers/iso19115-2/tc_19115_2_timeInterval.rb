# MdTranslator - minitest of
# writers / iso19115_2 / timeInterval

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TimeInterval < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimePeriod = mdHash[:metadata][:resourceInfo][:timePeriod]
   TDClass.add_timeInterval(hTimePeriod)

   @@mdHash = mdHash

   def test_timeInterval_year

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[1]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInterval_month

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_timeInterval(hTimePeriod,1, 'month')

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[2]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInterval_day

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_timeInterval(hTimePeriod,1, 'day')

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[3]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInterval_hour

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_timeInterval(hTimePeriod,1, 'hour')

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[4]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInterval_minute

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_timeInterval(hTimePeriod,1, 'minute')

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[5]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInterval_second

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_timeInterval(hTimePeriod,1, 'second')

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_timeInterval',
                                                '//gmd:temporalElement[6]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
