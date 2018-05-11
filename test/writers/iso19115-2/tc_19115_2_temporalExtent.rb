# MdTranslator - minitest of
# writers / iso19115_2 / class_temporalExtent

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TemporalExtent < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_temporalExtent',
                                                '//gmd:EX_Extent[1]',
                                                '//gmd:EX_Extent', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
