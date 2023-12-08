# MdTranslator - minitest of
# writers / iso19115_3 / class_timeInstant

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151TimeInstant < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimeI = TDClass.build_timeInstant('TIID001',nil,'2018-05-02T08:48:00-00:09')
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] = []
   mdHash[:metadata][:resourceInfo][:extent][0][:temporalExtent] << { timeInstant: hTimeI }
   mdHash[:metadata][:resourceInfo][:extent][0].delete(:geographicExtent)

   @@mdHash = mdHash

   def test_timeInstant_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_timeInstant',
                                                '//gex:temporalElement[1]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_timeInstant_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTimeI = hIn[:metadata][:resourceInfo][:extent][0][:temporalExtent][0][:timeInstant]
      hTimeI.delete(:id)
      hTimeI.delete(:identifier)
      hTimeI.delete(:description)
      hTimeI.delete(:instantName)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_timeInstant',
                                                '//gex:temporalElement[2]',
                                                '//gex:temporalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
