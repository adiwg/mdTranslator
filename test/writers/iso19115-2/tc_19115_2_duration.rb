# MdTranslator - minitest of
# writers / iso19115_2 / duration

# History:
#  Stan Smith 2018-04-19 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Duration < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_duration_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1,2,3,4,5,6)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_duration',
                                                '//gmd:temporalElement[1]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_duration_year

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_duration',
                                                '//gmd:temporalElement[2]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_duration_date

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1,2,3)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_duration',
                                                '//gmd:temporalElement[3]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_duration_time

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hIn[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,nil,nil,nil,4,5,6)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_duration',
                                                '//gmd:temporalElement[4]',
                                                '//gmd:temporalElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
