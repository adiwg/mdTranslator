# MdTranslator - minitest of
# writers / iso19115_1 / class_liProcessStep

# History:
#  Stan Smith 2019-09-25 add support for LE_Source and LE_ProcessStep
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151liProcessStep < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hStep = TDClass.build_liProcessStep_full
   hLineage = TDClass.lineage
   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_processStep_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hStep = hIn[:metadata][:resourceLineage][0][:processStep][0]
      hStep[:processor].delete_at(1)
      hStep[:stepSource].delete_at(1)
      hStep[:reference].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[1]',
                                                '//mrl:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStep_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      aSteps = hIn[:metadata][:resourceLineage][0][:processStep]
      aSteps << TDClass.build_liProcessStep('PS002', 'step two')

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[2]',
                                                '//mrl:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[3]',
                                                '//mrl:processStep', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStep_array

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[4]',
                                                '//mrl:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStep_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hStep = hIn[:metadata][:resourceLineage][0][:processStep][0]
      hStep[:stepId] = ''
      hStep[:rationale] = ''
      hStep[:timePeriod] = {}
      hStep[:processor] = []
      hStep[:stepSource] = []
      hStep[:reference] = []
      hStep[:scope] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[5]',
                                                '//mrl:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hStep.delete(:stepId)
      hStep.delete(:processor)
      hStep.delete(:stepSource)
      hStep.delete(:reference)
      hStep.delete(:timePeriod)
      hStep.delete(:rationale)
      hStep.delete(:scope)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liProcessStep',
                                                '//mrl:processStep[5]',
                                                '//mrl:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
